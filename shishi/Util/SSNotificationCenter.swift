//
//  SSNotification.swift
//  shishi
//
//  Created by tb on 2017/8/13.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SSNotificationCenter: NotificationCenter {
    static let keyPrefix = "SSNotification_"
    struct Names {
        //添加新作品
        static let addWritting: NSNotification.Name = Notification.Name(rawValue:keyPrefix + "addWritting")
        //编辑作品
        static let updateWritting: NSNotification.Name = Notification.Name(rawValue:keyPrefix + "updateWritting")
        //字体大小变化
        static let updateFontSize: NSNotification.Name = Notification.Name(rawValue:keyPrefix + "updateFontSize")
        //作者名字变化
        static let updateAuthorName: NSNotification.Name = Notification.Name(rawValue:keyPrefix + "updateAuthorName")
        //APP字体语言变化
        static let updateAppLanguage: NSNotification.Name = Notification.Name(rawValue:keyPrefix + "updateAppLanguage")
    }
}
