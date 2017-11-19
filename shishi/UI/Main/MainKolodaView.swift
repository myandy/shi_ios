//
//  MainKolodaView.swift
//  shishi
//
//  Created by tb on 2017/8/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

//主页视图封装，
class MainKolodaView: UIView {
    
    var label: UILabel!
    
    internal var mirrorLayer: MirrorLoaderLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.label = UILabel(frame: self.bounds)
        self.addSubview(label)
        //label.text = writting.text
        label.snp.makeConstraints { (make) in
            let inset = convertWidth(pix: 20)
            make.left.equalToSuperview().offset(inset * 1.5).priority(750)
            make.top.equalToSuperview().offset(inset).priority(750)
            make.right.equalToSuperview().offset(-inset * 1.5).priority(750)
        }
        label.numberOfLines = 0
    }
    
    
    
    public func setup(writting: Writting) {
        self.label.text = writting.text
        if writting.bgImg != 0 {
            let poetryImage = PoetryImage(rawValue: Int(writting.bgImg))!
            let image = poetryImage.image()
            self.mirrorLayer = MirrorLoaderLayer()
            self.mirrorLayer?.image = image
            self.layer.insertSublayer(self.mirrorLayer!, at: 0)
        }
        else if let imageName = writting.bgImgName {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            // Get the Document directory path
            let documentDirectorPath:String = paths[0]
            // Create a new path for the new images folder
            let imagesDirectoryPath = (documentDirectorPath as NSString).appendingPathComponent("writting")
            let imagePath = (imagesDirectoryPath as NSString).appendingPathComponent(imageName)
            let image = UIImage(contentsOfFile: imagePath)!
            let imageView = UIImageView(image: image)
            self.insertSubview(imageView, at: 0)
            imageView.snp.makeConstraints({ (maker) in
                maker.edges.equalToSuperview()
            })
        }
        else {
            self.backgroundColor = UIColor.white
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mirrorLayer?.frame = self.bounds
        self.mirrorLayer?.setNeedsDisplay()
    }
}
