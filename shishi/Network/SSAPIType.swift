//
//  SSAPIType.swift
//  shishi
//
//  Created by tb on 2017/4/29.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Alamofire
import Moya

protocol SSAPIType {
    var headers: [String: String]? { get }
    
}

extension SSAPIType {
    var headers: [String: String]? {
        return nil
    }
}

extension TargetType {
    
    
    var sampleData: Data {
        return stubbedResponse(filename: "test")
    }
    
    
    var task: Task {
        return .request
    }
    
    
//    //完整URL
//    func fullUrl() -> String {
//        if self.path.isEmpty {
//            return self.baseURL.absoluteString
//        }
//        
//        return self.baseURL.appendingPathComponent(self.path).absoluteString
//    }
//    
//    //手动拼接地址和PARAMS，用于POST请求但是同时带QUERY参数
//    func url(base: String, params: [String: Any]?) -> URL {
//        if let params = params, var urlComponents = URLComponents(url: URL(string: base)!, resolvingAgainstBaseURL: false), !params.isEmpty {
//            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(params)
//            urlComponents.percentEncodedQuery = percentEncodedQuery
//            return urlComponents.url!
//        }
//        
//        return URL(string: base)!
//    }
//    
//    private func escape(_ string: String) -> String {
//        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
//        let subDelimitersToEncode = "!$&'()*+,;="
//        
//        var allowedCharacterSet = CharacterSet.urlQueryAllowed
//        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//        
//        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
//    }
//    
//    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
//        var components: [(String, String)] = []
//        
//        if let dictionary = value as? [String: Any] {
//            for (nestedKey, value) in dictionary {
//                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
//            }
//        } else if let array = value as? [Any] {
//            for value in array {
//                components += queryComponents(fromKey: "\(key)[]", value: value)
//            }
//        } else if let value = value as? NSNumber {
//            if value.isBool {
//                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
//            } else {
//                components.append((escape(key), escape("\(value)")))
//            }
//        } else if let bool = value as? Bool {
//            components.append((escape(key), escape((bool ? "1" : "0"))))
//        } else {
//            components.append((escape(key), escape("\(value)")))
//        }
//        
//        return components
//    }
//    
//    private func query(_ parameters: [String: Any]) -> String {
//        var components: [(String, String)] = []
//        
//        for key in parameters.keys.sorted(by: <) {
//            let value = parameters[key]!
//            components += queryComponents(fromKey: key, value: value)
//        }
//        
//        return components.map { "\($0)=\($1)" }.joined(separator: "&")
//    }
    
    
}
