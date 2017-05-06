//
//  Observable+.swift
//  shishi
//
//  Created by tb on 2017/5/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON
import Moya_SwiftyJSONMapper

public extension ObservableType where E == Response {
    
    //主页面HOME返回列表
    public func mapXiaLian() -> Observable<([String])> {
        let dataKey = "."
        return self.mapResultDic(type: [dataKey: JSON.self], arrayType: nil).flatMap() {
            observableDicTuple -> Observable<[String]> in
            
            let dataResultDic = observableDicTuple.0![dataKey] as! JSON
           
            let dataJson: JSON = dataResultDic["d"]
            if dataJson.isEmpty {
                let errorMsg = dataResultDic["Message"].stringValue
                let error = NSError(domain: errorMsg, code: 0, userInfo: nil)
                let moyaError = MoyaError.underlying(error)
                return Observable.error(moyaError)
            }
        
            var mapped = [String]()
            let jsonArray: [JSON] = dataJson["XialianSystemGeneratedSets"].arrayValue
            for jsonObject in jsonArray {
                let subJsonArray = jsonObject["XialianCandidates"].arrayValue
                for subJsonObject in subJsonArray {
                    if let xianLian = subJsonObject.string, !xianLian.isEmpty {
                        mapped.append(xianLian)
                    }
                }
                
            }
            
            return Observable.create { observer in

//                let mappedArray0 = (observableDicTuple.1!["works"]!).map({$0 as! Work})
                observer.onNext(mapped)
                return Disposables.create {
                    observer.onCompleted()
                }
            }
        }
    }
}
