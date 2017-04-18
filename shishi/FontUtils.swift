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
    
    public static let FONTS=["FZQingkeBenYueSongS-R-GB","fzsongkebenxiukai_fanti"]
    
    public static func setFont( view : UIView){
        let userDefault = UserDefaults.standard
        let font = userDefault.integer(forKey: "font")
        if view is UILabel{
            let lable = view as! UILabel
            lable.font=UIFont(name:FONTS[font],size:lable.font.pointSize)
        }
        else {
            for subview in view.subviews{
                setFont(view: subview)
            }
        }
    }
    
}

