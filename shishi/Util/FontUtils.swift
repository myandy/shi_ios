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
//    "CloudSongFangGBK","CloudKaiTiGBK"
    public static let FONTS = ["CloudSongFangGBK"]
    
    
    public static func setFont(_ view : UIView){
       

        if let label = view as? UILabel{
            label.font = fontFromUserDefault(pointSize: label.font.pointSize)
        }
    // to do 其它控件的字体设置
//        else if let textField = view as? UITextField {
//            textField.font = fontFromUserDefault(pointSize: textField.font!.pointSize)
//        }
//        else if let textView = view as? UITextView {
//            textView.font = fontFromUserDefault(pointSize: textView.font!.pointSize)
//        }

            
            
        else {
            for subview in view.subviews{
                setFont(subview)
            }
        }
        SSAppLanguage.fixViewLanguage(view: view)
    }
    
    public static func fontFromUserDefault(pointSize: CGFloat) -> UIFont {
//        let userDefault = UserDefaults.standard
//        let font = userDefault.integer(forKey: "font")
        return UIFont(name:FONTS[0], size:pointSize)!
    }
    
}

