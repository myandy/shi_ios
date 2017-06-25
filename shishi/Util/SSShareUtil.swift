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
    
    public func shareToSystem(controller:UIViewController, image:UIImage) {
//        let data = UIImagePNGRepresentation(image)
//        let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let imagePath = (docPath as NSString).appendingPathComponent("test.png")
//        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        
//        let myShare = "test share"
//        let image = UIImage(named: "back")! as AnyObject
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.present(shareVC, animated: true, completion: nil)
        
//        AssetsLibraryUtil.default.saveImageFile(filePath: imagePath) { (url, identify, error) in
//            DispatchQueue.main.sync {
//                
//            }
//        }
        
        

    }
    
}
