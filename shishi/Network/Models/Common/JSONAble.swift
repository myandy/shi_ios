//protocol JSONAbleType {
//    static func fromJSON(_: [String: AnyObject]) -> Self
//}

import Moya_SwiftyJSONMapper
import SwiftyJSON

extension String : ALSwiftyJSONAble {
    public init?(jsonData:JSON){
        self = jsonData.stringValue
    }
}

extension JSON : ALSwiftyJSONAble {
    public init?(jsonData:JSON){
        self = jsonData
    }
}

extension UInt64 : ALSwiftyJSONAble {
    public init?(jsonData:JSON){
        self = jsonData.uInt64Value
    }
}

extension Int : ALSwiftyJSONAble {
    public init?(jsonData:JSON){
        self = jsonData.intValue
    }
}
