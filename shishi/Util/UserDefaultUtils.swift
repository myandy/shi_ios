//
//  UserDefaultUtils.swift
//  shishi
//
//  Created by andymao on 2017/5/20.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

public class UserDefaultUtils {
    
    static let userDefault = UserDefaults.standard
    
    public static func getDynasty() -> Int {
        return userDefault.integer(forKey: "dynasty")
    }
    
    public static func setDynasty(_ i: Int) {
        userDefault.set(i, forKey: "dynasty")
    }
    

    public static func getYunshu() -> Int {
        return userDefault.integer(forKey: "yunshu")
    }
    
    public static func setYunshu(_ i: Int) {
        userDefault.set(i, forKey: "yunshu")
    }
    
}
