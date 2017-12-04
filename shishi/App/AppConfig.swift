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
        //日期
        static let timeFontSize: CGFloat = 16
        //作品作者文字的初始大小
        static let writtingAuthorFontSize: CGFloat = 16
        
        //如果用内置图片做背景时的文字颜色
        static let textColorForPaper: UIColor = UIColor(hexColor: "A9A9AB")
        //如果用相册图片做背景时的文字颜色
        static let textColorForAlbum: UIColor = UIColor.white
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
