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
    
    public static func getFont() -> Int {
        return userDefault.integer(forKey: "font")
    }
    
    public static func setFont(_ i: Int) {
        userDefault.set(i, forKey: "font")
    }
    
    public static func isCheckPingze() -> Bool {
        return !userDefault.bool(forKey: "notcheckPingze")
    }
    
    public static func setCheckPingze(_ bool: Bool) {
        userDefault.set(!bool, forKey: "notcheckPingze")
    }
    
    public static func getUsername() -> String? {
        return userDefault.string(forKey: "username")
    }
    
    public static func setUsername(_ i: String) {
        userDefault.set(i, forKey: "username")
    }
    
}
