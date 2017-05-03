import Foundation
import Moya
import RxSwift
import Alamofire




private let REQUEST_RETRY_COUNT = 3


class OnlineProvider<Target>: RxMoyaProvider<Target> where Target: TargetType {

    private let online: Observable<Bool>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
        manager: Manager = Alamofire.SessionManager.default,
        plugins: [PluginType] = [],
        online: Observable<Bool> = connectedToInternetOrStubbing()) {

            self.online = online
            super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins)
    }

    override func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = super.request(token)
        return online
//            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
//            .throttle(0.01, scheduler: MainScheduler.instance)
//            .delay(3, scheduler: MainScheduler.instance)
            .flatMap { _ in // Turn the online state into a network request
                
                return actualRequest
            }

    }
    


}



protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }
    
}

struct DuiShiNetwork: NetworkingType {
    typealias T = DuiShiAPI
    let provider: OnlineProvider<T>
    
}






// "Public" interfaces
extension DuiShiNetwork {
    /// Request to fetch a given target. Ensures that valid XApp tokens exist before making request
    func request(token: DuiShiAPI, defaults: UserDefaults = UserDefaults.standard) -> Observable<Moya.Response> {
        return self.provider.request(token).retry(REQUEST_RETRY_COUNT)
    }
}







// Static methods
class Networking {
    //自定义上传数据格式
//    internal static let LEO_UPLOAD_PARAM_KEY = "upload_data"
    
    typealias HeadClosure = (_ target: TargetType) -> [String: String]?
    
    
    
    static var versionString: String {
        get {
            let versionObject = Bundle.main.infoDictionary!["CFBundleVersion"]
            return versionObject as! String
        }
    }

    class func newDuiShiNetwork() -> DuiShiNetwork {
        return DuiShiNetwork(provider: newProvider(plugins: plugins, headClosure: authHeadClosure))
    }
    
    

    //StubbingNetworking
    static func newDuiShiStubbingNetwork() -> DuiShiNetwork {
        return DuiShiNetwork(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, plugins: plugins, online: .just(true)))
    }

    
    
    //基本头部信息
    static var agentHeadClosure: HeadClosure {
        get {
            return { target in
                
                //let headDic:[String: String] = ["x-leo-agent-version": versionString, "x-leo-agent-platform": "ios"]
                
                let headDic:[String: String] = [:]
                
                return headDic
            }
        }
        
    }
    
    
    
    //登录用户HEAD信息
    static var authHeadClosure: HeadClosure {
        get {
            return { target in
                let headDic:[String: String] = Networking.agentHeadClosure(target)!
               
//                if let uid = self.uid, let sidSeq = self.sidSeq{
//                    headDic["X-Leo-rid"] = "\(requestIndex)"
//                    setRequestIndex(index: requestIndex + 1)
//
//                    headDic["X-Leo-uid"] = uid
//                    headDic["X-Leo-sid-seq"] = sidSeq
//                    
//                }
                
                return headDic
            }
        }
        
    }
    
    static func endpointsClosure<T>(headClosure: HeadClosure? = nil) -> (T) -> Endpoint<T> where T: TargetType, T: SSAPIType{
        return  { (target: T) -> Endpoint<T> in
            let bodyParameterEncoding = target.parameterEncoding
            let endpoint: Endpoint<T> = Endpoint<T>(url: url(route: target), sampleResponseClosure:
                {
                    .networkResponse(200, target.sampleData)
                }, method: target.method, parameters: target.parameters, parameterEncoding:bodyParameterEncoding)
            

            
            return endpoint
        }
        
    }

    static func stubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        let networkActivityPlugin = NetworkActivityPlugin { (change) -> () in
            switch(change){
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }        
        }
        return [
//            NetworkCatchPlugin(),
//            NetworkLogger(
//                whitelist: { target -> Bool in
//
//                    return false
//                }
//                ,blacklist: { target -> Bool in
//
//                    return false
//            })

            NetworkLoggerPlugin(verbose: true),
            networkActivityPlugin

        ]
    }
    



    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver<T>() -> MoyaProvider<T>.RequestClosure where T: TargetType {
        return { (endpoint, closure) in
//            var request = endpoint.urlRequest!
//            request.httpShouldHandleCookies = false
//            if let params = endpoint.parameters {
//                //自定义上传数据格式
//                //临时做法，需要优化
//                if let dataParam = params[LEO_UPLOAD_PARAM_KEY] as? Data {
//                    request.httpBody = dataParam
//
//                }
//            }
            //TEST,未起作用
//            request.timeoutInterval = 1
//            if let target = endpoint as? LEOAPIType {
//                
//                target.customRequest(request: request)
//            }
            closure(.success(endpoint.urlRequest!))

        }
    }
    
    static func newProvider<T>(plugins: [PluginType], headClosure: HeadClosure? = nil) -> OnlineProvider<T> where T: TargetType, T: SSAPIType {
        return OnlineProvider(endpointClosure: Networking.endpointsClosure(headClosure: headClosure),
                              requestClosure: Networking.endpointResolver(),
                              stubClosure: Networking.stubBehaviour,
                              plugins: plugins)
    }
    
    //自定义文件上传编码格式
    class func customUploadParameterEncoding(data:Data) -> ParameterEncoding {
        return LeoParameterEncoding(data: data)
    }
    
    class LeoParameterEncoding : ParameterEncoding {
        var data: Data!
        init(data: Data) {
            self.data = data
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            guard let request = urlRequest as? NSMutableURLRequest else {
                return urlRequest as! URLRequest
            }
            request.httpBody = self.data
            return request as URLRequest
        }
    }
}




// MARK: - Provider support

func stubbedResponse(filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return NSData(contentsOfFile: path!)! as Data
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding( withAllowedCharacters: .urlHostAllowed)!
        //return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

func url(route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}








