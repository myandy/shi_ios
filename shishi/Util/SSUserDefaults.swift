//
//  SSUserDefaults.swift
//  shishi
//
//  Created by tb on 2017/9/24.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SSUserDefaults: UserDefaults {
    struct Keys {
        static let prefixKey = "SSUserDefaults_"
        
        //字体调整大小
        static let fontOffset = prefixKey + "fontOffset"
        
    }
}
