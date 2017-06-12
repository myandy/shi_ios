//
//  AssetsLibraryUtil.swift
//  post
//
//  Created by yyf on 2016/11/30.
//  Copyright © 2016年 leo. All rights reserved.
//

import Photos
//import AssetsLibrary

class AssetsLibraryUtil: NSObject {
    open static let `default`: AssetsLibraryUtil = {
        return AssetsLibraryUtil()
    }()
    
    public typealias SaveHandle = ((_ url:URL?, _ localIdentifier:String?, _ error:Error?) -> Void)
    
    
//    private var isShouldSave = false
//    private var filePathSouldSave: String?
//    private var saveHandleShouldSave: SaveHandle?
    
    override init() {
        super.init()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.becomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
    }
    
    //将视频保存到assets-library并返回路径,localIdentifier
    //请注意多线程问题，
    func saveVideoFile(filePath: String, handle: SaveHandle?) {
        
        if !self.hasPermissions() {

            PHPhotoLibrary.requestAuthorization({ [unowned self] (status) in
                log.debug("\(status)")
                if status == .denied {
                    let error = NSError(domain: "user restricted", code: 0, userInfo: nil)
                    handle?(nil, nil, error)
                }
                else {
                    self.doSaveVideoFile(filePath: filePath, handle: handle)
                }
            })
            return
        }
        
        self.doSaveVideoFile(filePath: filePath, handle: handle)
    }
    
    func saveImageFile(filePath: String, handle: SaveHandle?) {
        
        if !self.hasPermissions() {
            
            PHPhotoLibrary.requestAuthorization({ [unowned self] (status) in
                log.debug("\(status)")
                if status == .denied {
                    let error = NSError(domain: "user restricted", code: 0, userInfo: nil)
                    handle?(nil, nil, error)
                }
                else {
                    self.doSaveImageFile(filePath: filePath, handle: handle)
                }
            })
            return
        }
        
        self.doSaveImageFile(filePath: filePath, handle: handle)
    }
    
    func doSaveVideoFile(filePath: String, handle: SaveHandle?) {
        let videoURL = URL(fileURLWithPath: filePath)
        let photoLibrary = PHPhotoLibrary.shared()
        var videoAssetPlaceholder:PHObjectPlaceholder!
        photoLibrary.performChanges({
            let request = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
            videoAssetPlaceholder = request!.placeholderForCreatedAsset
        }, completionHandler: { success, error in
            
            if success {
                let localID = videoAssetPlaceholder.localIdentifier
                
                var assetID = localID.replacingOccurrences( of:
                    "/.*", with: "")
                assetID = assetID.components(separatedBy: "/").first!
                //                                            let ext = "mp4"
                let ext = (filePath as NSString).pathExtension
                let assetURLStr =
                "assets-library://asset/asset.\(ext)?id=\(assetID)&ext=\(ext)"
                
                // Do something with assetURLStr
                
                handle?(URL(string: assetURLStr), localID, nil)
                
            }
            else {
                handle?(nil, nil, error)
            }
        })
    }
    
    func doSaveImageFile(filePath: String, handle: SaveHandle?) {
        let fileURL = URL(fileURLWithPath: filePath)
        let photoLibrary = PHPhotoLibrary.shared()
        var fileAssetPlaceholder:PHObjectPlaceholder!
        photoLibrary.performChanges({
            let request = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: fileURL)
            fileAssetPlaceholder = request!.placeholderForCreatedAsset
        }, completionHandler: { success, error in
            
            if success {
                let localID = fileAssetPlaceholder.localIdentifier
                
                var assetID = localID.replacingOccurrences( of:
                    "/.*", with: "")
                assetID = assetID.components(separatedBy: "/").first!
                //                                            let ext = "mp4"
                let ext = (filePath as NSString).pathExtension
                let assetURLStr =
                "assets-library://asset/asset.\(ext)?id=\(assetID)&ext=\(ext)"
                
                // Do something with assetURLStr
                
                handle?(URL(string: assetURLStr), localID, nil)
                
            }
            else {
                handle?(nil, nil, error)
            }
        })
    }

    
    func assetsLibraryRemoveFile( with localAssetIdentifier : String) {
        
        // Find asset that we previously stored
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: [localAssetIdentifier], options: PHFetchOptions())
        
        // Fetch asset, if found, delete it
        if let fetchedAssets = assets.firstObject {
            let delShotsAsset: NSMutableArray! = NSMutableArray()
            delShotsAsset.add(fetchedAssets)
            PHPhotoLibrary.shared().performChanges({ () -> Void in
                
                // Delete asset
                PHAssetChangeRequest.deleteAssets(delShotsAsset)
                
            }, completionHandler: { (success, error) -> Void in
                
            })
        }
        
    }
    
    /**
     判断相册权限
     
     - returns: 有权限返回ture， 没权限返回false
     */
    
    func hasPermissions() -> Bool {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if status != .authorized {
            return false
        }else {
            return true
        }
    }
    
}
