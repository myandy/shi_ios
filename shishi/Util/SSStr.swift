//
//  SSStr.swift
//  shishi
//
//  Created by tb on 2017/5/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSStr: NSObject {
    struct Duishi {
        static var duishi                       : String { return NSLocalizedString("DUISHI", comment: "") }
        static var refresh                       : String { return NSLocalizedString("REFRESH", comment: "") }
    }
    
    static let DYNASTYS = ["全部朝代","先秦","汉朝","魏晋","南北朝","唐朝","北宋","南宋","元朝","明朝","清朝","近代","当代"]
    static let CHOOSE_DYNASTY = "选择朝代"
    
    struct Setting{
        static let YUN_TITLE = "韵典"
        static let YUN_CHOCICIES = ["中华新韵，平水韵，词林正韵"]
        static let FONT_TITLE = "字体切换"
        static let FONT_CHOCICIES = ["·中华新韵，平水韵，词林正韵"]
    }
   
}
