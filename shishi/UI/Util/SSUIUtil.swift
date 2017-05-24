//
//  SSUIUtil.swift
//  shishi
//
//  Created by tb on 2017/5/24.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

let BASE_HEIGTH: CGFloat = 1334.0
let BASE_WIDTH: CGFloat =  750.0


var SCREEN_WIDTH: CGFloat = {
    return UIScreen.main.bounds.size.width
}()
var SCREEN_HEIGHT = {
    return UIScreen.main.bounds.size.height
}()



func convertWidth(pix: CGFloat) -> CGFloat {
    return pix * SCREEN_WIDTH / BASE_WIDTH
}


func convertHeight(pix: CGFloat) -> CGFloat {
    return pix * SCREEN_HEIGHT / BASE_HEIGTH
}

//class SSUIUtil: NSObject {
//
//}
