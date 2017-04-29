//
//  HTTPProtocal.swift
//  xbase
//
//  Created by yyf on 16/8/15.
//  Copyright © 2016年 Leomaster. All rights reserved.
//

//import Foundation




public class HTTPProtocal {
    //APP已经禁止HTTP明文传输
    static let HTTP = "http://"
    
    static let HTTPS = "https://"
    //服务器IP地址
    //测试地址
    //static let SERVER_ADDRESS_USER_DEBUG = "https://192.168.1.242:8000/account"
    //正式地址
    //帐号系统
    //static let SERVER_ADDRESS_USER = "https://account.ss.leook.com/account"
    //static let SERVER_ADDRESS_USER = SERVER_ADDRESS_API + "/user"
    
    static let SERVER_HOST_API = "api.postto.leook.com"
    //static let SERVER_ADDRESS_UPLOAD = HTTPS + "upload.postto\(SERVER_PATH_CN).leook.com"
    static let SERVER_ADDRESS_UPLOAD = SERVER_ADDRESS_API
    //bases
    static let SERVER_ADDRESS_API = HTTPS + SERVER_HOST_API
    static let SERVER_ADDRESS_FILE = SERVER_ADDRESS_API

    
    //参数
    static let URL_PARAM_DATA = "data"
    static let URL_PARAM_LIST = "list"
    static let URL_PARAM_PAGE = "pageInfo"
    static let URL_PARAM_INFO = "info"
    static let URL_PARAM_NEXT = "next"
    
    //生日的格式值: yyyy-mm-dd
    static var birthdayFormatString: String {
        return "yyyy-mm-dd"
    }
    
    //空字符串
    static let VALUE_EMPTY_STRING = ""
    //默认滤镜百分比
    static let VALUE_DEFAULT_FILTER_PECENT: Float = 1
    //默认文本不透明度
    static let VALUE_DEFAULT_FILTER_OPACITY: Float = 1
}

//错误码
public enum ErrorCode : String {
    case unkonw = "unkown",
    //用户未登录或 session 失效。均需要重新登录
    unauthorized = "401",
    //权限不够，例如更新不属于自己的BASE
    notAllow = "403",
    passwordError = "462",
    notExist = "404",
    //已经存在了
    accountExist = "485",
    invalidSession = "463",
    //430: 客户端版本过低，此时应该提示升级
    versionToLow = "422"

    
    static func errorFromString(code: String) ->ErrorCode {
        if let errorCode = ErrorCode(rawValue: code) {
            return errorCode
        }
        return ErrorCode.unkonw
    }
}


//性别
public enum Gender : String {
    case Unkown = "",
    Female = "F",
    Male = "M"
    
    init?(index: Int) {
        switch index {
        case Gender.Female.index:
            self = .Female
        case Gender.Male.index:
            self = .Male
        default:
            self = .Unkown
        }
    }
    
    var index: Int {
        switch self {
        case .Female:
            return 1
        case .Male:
            return 2
        default:
            return 0
        }
    }
}



//file type 说明
//type =
//0 -- 非gif 图片文件
//1 -- 视频文件
//3 -- gif 图片文件
public enum FileType : Int {
    case Image = 0,
    Video = 1,
    Gif = 3,
    Unkown = -1
}


//心情
public enum LEOEmotion : String {
    case happy = "1",
    quiet = "2",
    other = "3",
    angry = "4",
    melancholy = "5",
    terror = "6",
    awkward = "7",
    wordless = "8",
    sad = "9",
    test = "0",
    remix = "-1" //remix 或者默认选中

}

