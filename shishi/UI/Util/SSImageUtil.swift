//
//  SSImageUtil.swift
//  shishi
//
//  Created by tb on 2017/6/14.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSImageUtil: NSObject {
    public static func genShiImage(_ bgImage: UIImage?, _ title: String, content: String) -> UIImage {
        let bgView = UIView(frame: UIScreen.main.bounds)
        let drawView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        bgView.addSubview(drawView)
        drawView.backgroundColor = UIColor.red
        
        let image = SSImageUtil.image(with: drawView)
        
        return UIImage()
    }
    
    public static func image(with view: UIView) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.layer.frame.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return viewImage
    }
}
