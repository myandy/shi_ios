//
//  AppConfig.swift
//  xbase
//
//  Created by yyf on 16/8/17.
//  Copyright © 2016年 Leomaster. All rights reserved.
//

import Foundation
import UIKit

class AppConfig {
   
    struct Constants {
        
        
       
        static let TAP_THROTTLE:Double = 0.3
        
        //字体变化每次步径
        static let increaseFontStep: CGFloat = 2.0
        
        //介绍文字的初始大小
        static let introFontSize: CGFloat = 15
        //标题文字的初始大小
        static let titleFontSize: CGFloat = 18
        //作者文字的初始大小
        static let authorFontSize: CGFloat = 34
        //内容文字的初始大小
        static let contentFontSize: CGFloat = 16
    }
    
    
    //开发环境
    static var isDevelop: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    
    //使用短路网络
    static var isStubbingNetwork: Bool {
        #if DEBUG
            return false
        #else
            return false
        #endif
        
    }
    
   
    
    //单元测试不启动界面
    static var isUnitTest: Bool {
        #if DEBUG
            return false
        #else
            return false
        #endif
    }
}
