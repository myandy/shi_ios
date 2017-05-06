//
//  BasesAPI.swift
//  xbase
//
//  Created by yyf on 16/8/26.
//  Copyright © 2016年 Leomaster. All rights reserved.
//


import RxSwift
import Moya
import Alamofire


enum DuishiAPI {
    
    case xiaLian(shangLian: String, locker: String?)
    
    static let emptyLoker = "0"
}

extension DuishiAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
        case .xiaLian:
            return "/GetXiaLian"
            
       
            
            //end
        }
    }
    
    var base: String { return "http://couplet.msra.cn/app/CoupletsWS_V2.asmx" }
    var baseURL: URL {
        return URL(string: base)!
    }
    
    
    
    var parameters: [String: Any]? {
        var apiParams: [String: Any]? = nil
        switch self {
            
        case .xiaLian(let shangLian, let locker):
            var lockerString = locker
            if lockerString == nil {
                lockerString = ""
                for _ in 0..<shangLian.characters.count {
                    lockerString! += type(of: self).emptyLoker
                }
            }
            
            apiParams = [
                "shanglian":  shangLian,
                "xialianLocker":  lockerString!,
                "isUpdate":  false,
            ]
            
       
            
            
            //end
        }
        
        return apiParams
    }
    
    var method: Moya.Method {
        switch self {
        case .xiaLian:
            return .post
            
            
            
            //end
        }
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    
}

extension DuishiAPI: SSAPIType {
}


