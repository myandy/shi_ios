//
//  ModelExtention.swift
//  shishi
//
//  Created by tb on 2017/8/13.
//  Copyright © 2017年 andymao. All rights reserved.
//


extension Writting {
    class var textSeparator: String {
        return "\n"
    }
    
    var former: Former {
        return FormerDB.getFormer(with: self.formerId)!
    }
    
    var textArray: [String] {
        return self.text.components(separatedBy: type(of: self).textSeparator)
    }
}
