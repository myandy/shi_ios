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
        static let addWritting:NSNotification.Name = Notification.Name(rawValue:keyPrefix + "addWritting")
    }
}
