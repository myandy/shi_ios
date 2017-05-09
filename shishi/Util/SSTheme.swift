//
//  SSTheme.swift
//  shishi
//
//  Created by tb on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSTheme: NSObject {
    //MARK:-颜色
    struct ColorInt {
        public static let BACK =  0xf6f6f6
        public static let DIVIDE =  0xafafaf
    }
    
    //MARK:-颜色
    struct Color {
        
        static let C6 = UIColor.init(red: 0x32 / 255.0, green: 0x46 / 255.0, blue: 0x5d / 255.0, alpha: 1.0)
        
        static let C9 = UIColor.init(red: 0x23 / 255.0, green: 0xcc / 255.0, blue: 0xcc / 255.0, alpha: 1.0)
        
        //按钮蓝色背景-普通
        static let blueBtnNormal = UIColor.init(red: 0x37 / 255.0, green: 0x86 / 255.0, blue: 0xdb / 255.0, alpha: 1.0)
        //按钮蓝色背景-按下
        static let blueBtnHighlighted = blueBtnNormal.withAlphaComponent(0x80/0xff)
        
        //分割线
        static let separator = UIColor.init(red: 0xcc / 255.0, green: 0xcc / 255.0, blue: 0xcc / 255.0, alpha: 1.0)
        
        static let settingBack = UIColor.init(red: 0x33 / 255.0, green: 0x33 / 255.0, blue: 0x33 / 255.0, alpha: 1.0)
        
        static let settingLine = UIColor.init(red: 0x22 / 255.0, green: 0x22 / 255.0, blue: 0x22 / 255.0, alpha: 1.0)
        
    }
    
    //尺寸
    struct Dimens {
        //分割线
        static let separatorHeight: CGFloat = 1
    }
}
