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
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.present(shareVC, animated: true, completion: nil)
    }
    
    public func shareToSystem(controller:UIViewController, title: String, image: UIImage?, urlString: String, handler:((Error?) -> Void)? = nil) {
        guard !title.isEmpty, let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            handler?(error)
            return
        }
        var activityItems = [title, url] as [Any]
        if let image = image {
            activityItems.append(image)
        }
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        activityVC.completionWithItemsHandler = { (activity, success, items, error) in
            if !success {
                if let error = error {
                    log.debug(error)
                    handler?(error)
                }
                else {
                    //let error = NSError(domain: "", code: 0, userInfo: nil)
                    handler?(nil)
                }
                
            }
            else {
                handler?(nil)
            }
        }
        controller.present(activityVC, animated: true)
    }
    
    public func shareToWB(controller:UIViewController, title: String, image: UIImage, url:String) {
        let webObject = WBWebpageObject()
        
        webObject.title = title
        webObject.description = description
        webObject.webpageUrl = url
//        let smallImage = thumbImage.compressImage(maxLength:30 * 1024)
        webObject.thumbnailData = UIImageJPEGRepresentation(image, 1)
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMDDHHmmss"
        webObject.objectID = "weibo_\(formatter.string(from: Date()))"
        let message = WBMessageObject()
        message.mediaObject = webObject
        
        let req = WBSendMessageToWeiboRequest()
        req.message = message
        
        WeiboSDK.send(req)
    }
}
