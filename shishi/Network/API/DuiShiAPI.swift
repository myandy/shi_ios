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

private let materialPath = "/material"
private let worksPath = "/works"
private let backgroundPath = "/background"
private let editor = "/editor"

enum DuiShiAPI {
    
    case works(userId: String?, page: Int?, pageSize: Int)
    
}

extension DuiShiAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
        case .works:
            return worksPath
            
       
            
            //end
        }
    }
    
    var base: String { return HTTPProtocal.SERVER_ADDRESS_API }
    var baseURL: URL {
        return URL(string: base)!
    }
    
    
    
    var parameters: [String: Any]? {
        var apiParams: [String: Any]? = nil
        switch self {
            
        case .works:
            apiParams = [
                "page_size":  0,
            ]
            
       
            
            
            //end
        }
        
        return apiParams
    }
    
    var method: Moya.Method {
        switch self {
        case .works:
            return .get
            
            
            
            //end
        }
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    
}

extension DuiShiAPI: SSAPIType {
}


