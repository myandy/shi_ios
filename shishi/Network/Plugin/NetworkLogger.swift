import Foundation
import Moya
import Result
//import ISRemoveNull

/// Logs network activity (outgoing requests and incoming responses).
class NetworkLogger: PluginType {

    typealias Comparison = (TargetType) -> Bool

    let whitelist: Comparison
    let blacklist: Comparison

    init(whitelist: @escaping Comparison = { _ -> Bool in return true }, blacklist: @escaping Comparison = { _ -> Bool in  return true }) {
        self.whitelist = whitelist
        self.blacklist = blacklist
    }

    func willSendRequest(_ request: RequestType, target: TargetType) {
        // If the target is in the blacklist, don't log it.
        guard blacklist(target) == false else { return }
        
        if let params =  target.parameters{
            let paramsString = jsonStringWithDic(parameters: params as [String : AnyObject]!)
            log.debug("Sending request: \(request.request?.url?.absoluteString ?? String()), params:\(paramsString)")
        }
        else {
            log.debug("Sending request: \(request.request?.url?.absoluteString ?? String())")
        }
        if let head = request.request?.allHTTPHeaderFields {
            log.debug("head: \(head)")
        }
        if let body = request.request?.httpBody {
            if let bodyString = NSString(data:body, encoding:String.Encoding.utf8.rawValue) as? String {
                log.debug("body: \(bodyString)")
            }
            else{
                log.debug("bodyData LENGTH: \(body.count)")
            }
        }
    }

    func didReceiveResponse(_ result: Result<Moya.Response, Moya.MoyaError>, target: TargetType) {
        // If the target is in the blacklist, don't log it.
        guard blacklist(target) == false else { return }

        switch result {
        case .success(let response):
            if 200..<400 ~= response.statusCode {
                // If the status code is OK, and if it's not in our whitelist, then don't worry about logging its response body.
                //let dataString = jsonStringWithDic(response.dataDicByRemovingNull() as! [String : AnyObject])
                var dataString:String!
                do {
                    dataString = try response.mapString()
                }
                catch {
                    dataString = (NSString(data: response.data,
                        encoding: String.Encoding.utf8.rawValue) as! String)
                }
                
                log.debug("Received Success response(\(response.statusCode)) from \(response.response?.url?.absoluteString ?? String()), data:\(dataString)")
            }
            else {
                let dataString = NSString(data: response.data,
                         encoding: String.Encoding.utf8.rawValue) as! String
                log.warning("Received error response(\(response.statusCode)) from \(response.response?.url?.absoluteString ?? String()), data:\(dataString)")

            }
        case .failure(let error):
            // Otherwise, log everything.baogei
            //logger.log("Received networking error: \(error.nsError)")
            log.error("Received networking error: \(error)")
        }
    }
    
    //字典转JSON字符串
    func jsonStringWithDic(parameters: [String: AnyObject]!)->String?{
//        guard let parameters = parameters as? [String: String] else {
//            return ""
//        }
        for (_, value) in parameters {
            if value is NSData {
                return "can not serialization params"
            }
        }
        
        do {
            let theJSONData = try JSONSerialization.data(
                withJSONObject: parameters,
                options: JSONSerialization.WritingOptions.prettyPrinted)
            return NSString(data: theJSONData,
                            encoding: String.Encoding.utf8.rawValue) as? String
        }
        catch let error as NSError {
            log.error("Failed to load: \(error.localizedDescription)")
        }
        catch let error {
            log.error("Failed to load: \(error)")
        }
        
        return ""
    }
    
    
}

