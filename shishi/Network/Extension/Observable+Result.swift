//
//  Observable+Result.swift
//  xbase
//
//  Created by yyf on 16/8/17.
//  Copyright © 2016年 Leomaster. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON
import Moya_SwiftyJSONMapper
import RxCocoa
import NSObject_Rx

public let MAP_KEY_DOT = "."

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where E == Response {
    
//    public func mapResultOrError(response:Response) -> LEOError? {
//        var leoError:LEOError?
//        do {
//            let result = try response.map(to: LEOResult.self)
//            if !result.isOk {
//                if let errorCode = ErrorCode(rawValue: result.reason) {
//                    leoError = LEOError.errorFromErrorCode(code: errorCode)
//                }
//                else {
//                    leoError = LEOError.errorFromUnkwonServerReason(reason: result.reason)
//                }
//                
//            }
//        } catch let error {
//            leoError = LEOError.errorFromErrorType(error: error)
//        }
//        if let message = leoError?.description {
//            log.warning(message)
//        }
//        
//        return leoError
//    }
    
    
    //返回VOID
//    public func mapResult() -> Observable<Void> {
//        return flatMap { response -> Observable<Void> in
//            if let LEOError = self.mapResultOrError(response: response) {
//                return Observable.error(LEOError)
//            }
//            return Observable.just()
//        }
//    }
    
    
    
    
    
    
    //返回 [T], [TA]
    //如果没有KEY对应的数据，而且有另一个唯一数组值，默认做自动对应
    //也就是说如果只返回一个KEY对就一个数组，可以不用指定数组的KEY,使用默认的对应关系
    public func mapResultDic(type:[String: ALSwiftyJSONAble.Type]?, arrayType:[String: ALSwiftyJSONAble.Type]?) -> Observable<([String: ALSwiftyJSONAble]?, [String: [ALSwiftyJSONAble]]?)> {
        return flatMap { response -> Observable<([String: ALSwiftyJSONAble]?, [String: [ALSwiftyJSONAble]]?)> in
//            if let LEOError = self.mapResultOrError(response: response) {
//                return Observable.error(LEOError)
//            }
            
            let jsonObject = try response.mapJSON() //as! NSDictionary
            //如果返回的数据不是字典
            guard let dataObject = jsonObject as? NSDictionary else {
                var objectMappedArrayDic = [String: [ALSwiftyJSONAble]]()
                if let arrayType = arrayType, arrayType.keys.count == 1 , let dataArrayObject = jsonObject as? [Any] {
                    let key = arrayType.keys.first!
                    let value = arrayType[key]!
                    let objectMappedArray = dataArrayObject.flatMap { value.self.init(jsonData: JSON($0)) }
                    objectMappedArrayDic[key] = objectMappedArray
                }
                
                return Observable.create { observer in
                    observer.onNext(([String: ALSwiftyJSONAble](), objectMappedArrayDic))
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            
            var objectMapped: ALSwiftyJSONAble!
            var objectMappedDic:[String: ALSwiftyJSONAble]?
            var objectMappedArray: [ALSwiftyJSONAble]!
            var objectMappedArrayDic:[String: [ALSwiftyJSONAble]]?
            if let type = type {
                objectMappedDic = [String: ALSwiftyJSONAble]()
                for (key, value) in type {
                    if key == MAP_KEY_DOT {
                        objectMapped = value.init(jsonData: JSON(dataObject))
                    }
                    else {
                        //objectMapped = value.init(jsonData: JSON(dataObject[key]!))
                        //release模式下编译不过，拆成两行就能编译过了，为什么？
                        //let tmpObj = JSON(dataObject[key]!)
                        //objectMapped = value.init(jsonData: tmpObj)
                        if let tmpValue = dataObject[key] {
                            objectMapped = value.init(jsonData: JSON(tmpValue))
                        }
                    }

                    objectMappedDic![key] = objectMapped
                }
            }
            if let arrayType = arrayType {
                objectMappedArrayDic = [String: [ALSwiftyJSONAble]]()
                for (key, value) in arrayType {
                    //根据KEY找到数据
                    if let tempJsonData = dataObject[key] {
                        objectMappedArray = JSON(tempJsonData).arrayValue.flatMap { value.self.init(jsonData: $0) }
                        objectMappedArrayDic![key] = objectMappedArray
                    }
                        //如果没有KEY对应的数据，而且有另一个唯一数组值，默认做自动对应
                    else if dataObject.allKeys.count == 1, let tempJsonData = dataObject[dataObject.allKeys[0]], let jsonArray = JSON(tempJsonData).array {
                        objectMappedArray = jsonArray.flatMap { value.self.init(jsonData: $0) }
                        objectMappedArrayDic![key] = objectMappedArray
                    }
                    else {
                        objectMappedArrayDic![key] = [ALSwiftyJSONAble]()
                    }
                }
            }
            
            return Observable.create { observer in

                observer.onNext((objectMappedDic, objectMappedArrayDic))
                observer.onCompleted()
                return Disposables.create()
  
            }
            
        }
        
    }
    
}

