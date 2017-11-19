//
//  FontUtils.swift
//  shishi
//
//  Created by andymao on 16/11/24.
//  Copyright © 2016年 andymao. All rights reserved.
//

import Foundation
import UIKit



public class FontsUtils{
    
//    public static let FONTS = ["FZQingkeBenYueSongS-R-GB","fzsongkebenxiukai_fanti"]
    
    public static let FONTS = ["CloudSongFangGBK","CloudKaiTiGBK", "CloudSongFangGBK"]
    
    
    public static func setFont(_ view : UIView){
        
        if view is UILabel{
            let lable = view as! UILabel
            lable.font = fontFromUserDefault(pointSize: lable.font.pointSize)
        }
        else {
            for subview in view.subviews{
                setFont(subview)
            }
        }
    }
    
    public static func fontFromUserDefault(pointSize: CGFloat) -> UIFont {
        let userDefault = UserDefaults.standard
        let font = userDefault.integer(forKey: "font")
        return UIFont(name:FONTS[font], size:pointSize)!
    }
    
}

