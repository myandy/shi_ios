import RxSwift
import ReachabilitySwift
import Moya


func delayToMainThread(delay:Double, closure:@escaping ()->()) {
    let delayTime: DispatchTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: closure)
}

func delayToGlobalThread(delay:Double, closure:@escaping ()->()) {
    let delayTime: DispatchTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.global().asyncAfter(deadline: delayTime, execute: closure)
}


func random(min:UInt32,max:UInt32)->UInt32{
    return  arc4random_uniform(max-min)+min
}

//func logPath() -> NSURL {
//    let docs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
//    return docs.URLByAppendingPathComponent("logger.txt")
//}

//let logger = Logger(destination: logPath())

private let reachabilityManager = ReachabilityManager()

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternetOrStubbing() -> Observable<Bool> {
    let online = reachabilityManager.reach
    //let stubbing = Observable.just(APIKeys.sharedKeys.stubResponses)
    let stubbing = Observable.just(AppConfig.isStubbingNetwork)

    return Observable.combineLatest(online, stubbing) { isOnline, isStubbing in
        return isOnline || isStubbing
    }
    //return [online, stubbing].combineLatestOr()
}

func responseIsOK(response: Response) -> Bool {
    return response.statusCode == 200
}

func isReachable() -> Bool {
    return reachabilityManager.reachability.isReachable
}


func detectDevelopmentEnvironment() -> Bool {
    var developmentEnvironment = false
    #if DEBUG || (arch(i386) || arch(x86_64)) && os(iOS)
        developmentEnvironment = true
    #endif
    return developmentEnvironment
}

private class ReachabilityManager: NSObject {
    let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }

    public let reachability = Reachability()!

    override init() {
        super.init()

        reachability.whenReachable = { [weak self] _ in
            DispatchQueue.main.async() {
                self?._reach.onNext(true)
            }
        }

        reachability.whenUnreachable = { [weak self] _ in
            DispatchQueue.main.async() {
                self?._reach.onNext(false)
            }
        }

        do {
            try reachability.startNotifier()
            _reach.onNext(reachability.isReachable)
        } catch {
            print("Unable to start notifier")
        }
        
    }
}

func bindingErrorToInterface(error: Swift.Error) {
    let error = "Binding error to UI: \(error)"
    #if DEBUG
        fatalError(error)
    #else
        log.error(error)
    #endif
}


//func userProvider() -> OnlineProvider<UserAPI> {
//    return DataContainer.sharedInstance.userProvider.provider
//}
//网络层便捷入口
func duiShiNetwork() -> DuiShiNetwork {
    return DataContainer.default.duishiNetwork
}



//日志
import XCGLogger

private var documentsDirectory: URL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.endIndex-1]
}

private var cacheDirectory: URL {
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    return urls[urls.endIndex-1]
}


let log: XCGLogger = {
    let log = XCGLogger.default
    
    // By using Swift build flags, different log levels can be used in debugging versus staging/production. Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry.
    #if DEBUG
        let logPath : URL = cacheDirectory.appendingPathComponent("XCGLogger_debug.Log")
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath, fileLevel: .debug)
    #else
        let logPath : URL = documentsDirectory.appendingPathComponent("XCGLogger.Log")
        log.setup(level: .severe, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath, fileLevel: .debug)

    #endif
//    log.isXcodeColorsEnabled = true
//    log.xcodeColors = [
//        .Verbose: .lightGrey,
//        .Debug: .darkGrey,
//        .Info: .darkGreen,
//        .Warning: .orange,
//        .Error: .red,
//        .Severe: .whiteOnRed
//    ]
    return log
}()

