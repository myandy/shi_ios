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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
//        label.textColor = UIColor.white
        
        
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textColor = UIColor.white
        return label
    }()
    
    var contentLabel: UILabel!
    
    internal var mirrorLayer: MirrorLoaderLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.addSubview(self.titleLabel)
        let insetWidth = convertWidth(pix: 20)
        self.titleLabel.snp.makeConstraints { (maker) in
//            maker.top.equalToSuperview().inset(insets).priority(750)
            maker.left.equalToSuperview().offset(insetWidth * 1.5).priority(750)
            maker.top.equalToSuperview().offset(insetWidth).priority(750)
            maker.right.equalToSuperview().offset(-insetWidth * 1.5).priority(750)
        }
        
        self.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(convertWidth(pix:10))
        }
        
        self.contentLabel = UILabel(frame: self.bounds)
        self.contentLabel.textAlignment = .center
        self.addSubview(contentLabel)
        //label.text = writting.text
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(convertWidth(pix:10))
            make.centerX.width.equalTo(self.titleLabel)
//            make.left.equalToSuperview().offset(inset * 1.5).priority(750)
//            make.top.equalToSuperview().offset(inset).priority(750)
//            make.right.equalToSuperview().offset(-inset * 1.5).priority(750)
        }
        contentLabel.numberOfLines = 0
        
        self.updateFontSize()
        SSNotificationCenter.default.rx.notification(SSNotificationCenter.Names.updateFontSize).subscribe(onNext: { [weak self] notify in
            self?.updateFontSize()
        })
            .addDisposableTo(self.rx_disposeBag)
    }
    
    //更新字体大小
    internal func updateFontSize() {
        let fontSize = AppConfig.Constants.contentFontSize + DataContainer.default.fontOffset
        if self.contentLabel.font.pointSize != fontSize {
            self.contentLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
        let titleFontSize = AppConfig.Constants.titleFontSize + DataContainer.default.fontOffset
        self.titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        let authorFontSize = AppConfig.Constants.writtingAuthorFontSize + DataContainer.default.fontOffset
        self.authorLabel.font = UIFont.systemFont(ofSize: authorFontSize)
    }
    
    public func setup(writting: Writting) {
        self.titleLabel.text = writting.title
        self.authorLabel.text = writting.author
        self.contentLabel.text = writting.text
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
