//
//  ModelExtention.swift
//  shishi
//
//  Created by tb on 2017/8/13.
//  Copyright © 2017年 andymao. All rights reserved.
//


extension Writting {
    class var textSeparator: String {
        return "\n"
    }
    
    var former: Former {
        return FormerDB.getFormer(with: self.formerId)!
    }
    
    var textArray: [String] {
        return self.text.components(separatedBy: type(of: self).textSeparator)
    }
}

extension Writting : SearchModel{
    func getTitle() -> String {
        return title
    }
    
    func getDesc() -> String {
        return text
    }
    
    func getHint() -> String {
        return ""
    }
    
    func getImage() -> UIImage? {
        if let poetryImage = PoetryImage(rawValue: Int(self.bgImg)) {
            return poetryImage.image()
        }
        else {
            return self.albumImage()
        }
    }
}

//保存的本地图片
extension Writting {
    public func albumImage() -> UIImage? {
        guard let imageName = self.bgImgName else {
            return nil
        }
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let imagesDirectoryPath = (documentDirectorPath as NSString).appendingPathComponent("writting")
        let imagePath = (imagesDirectoryPath as NSString).appendingPathComponent(imageName)
        let image = UIImage(contentsOfFile: imagePath)!
        return image
    }
    
    public func saveAlbumBgImage(image: UIImage) {
        self.bgImg = -1
        self.bgImgName = self.saveImage(image: image)
    }
    
    fileprivate func saveImage(image: UIImage) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let imagesDirectoryPath = (documentDirectorPath as NSString).appendingPathComponent("writting")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
                
            }catch{
                print("Something went wrong while creating a new folder")
                return nil
            }
        }
        let imageName = Date().description
        let imagePath = (imagesDirectoryPath as NSString).appendingPathComponent(imageName)
        let data = UIImagePNGRepresentation(image)
        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        if success {
            return imageName
        }
        else {
            return nil
        }
    }
}
