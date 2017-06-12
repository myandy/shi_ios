//
//  SSShareUtil.swift
//  shishi
//
//  Created by tb on 2017/6/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSShareUtil: NSObject {
    public static let `default`: SSShareUtil = {
        return SSShareUtil()
    }()
    
    public func shareToSystem(controller:UIViewController, image:UIImage, message: String) {
        let data = UIImagePNGRepresentation(image)
        let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imagePath = (docPath as NSString).appendingPathComponent("test.png")
        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        
        let myShare = "test share"
        let image = UIImage(named: "back")! as AnyObject
        let url = URL(fileURLWithPath:imagePath) as! AnyObject
        //let urlToShare: AnyObject = URL(string: "http://m.baidu.com") as! AnyObject
        
        
        AssetsLibraryUtil.default.saveImageFile(filePath: imagePath) { (url, identify, error) in
            DispatchQueue.main.sync {
                let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [ myShare, image, url], applicationActivities: nil)
                controller.present(shareVC, animated: true, completion: nil)
            }
        }
        
        

    }
    
}
