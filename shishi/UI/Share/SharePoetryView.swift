//
//  SharePoetryView.swift
//  shishi
//
//  Created by tb on 2017/7/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

private let increaseFontStep: CGFloat = 2
private let minFontSize: CGFloat = 10
private let maxFontSize: CGFloat = 50
private let contentHorizonalMoveStep: CGFloat = convertWidth(pix: 10)

class SharePoetryView: UIView {
    
    public var bgImage: UIImage!
    
    //内容水平方向偏移
    internal var contentHorizonalOffset: CGFloat = 0
    
    public var textAlignment: NSTextAlignment = .center {
        didSet {
            self.setupConstraints()
        }
    }
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupUI() {
        self.backgroundColor = UIColor.white
        
        self.setupSubviews()
        self.setupConstraints()
        
        
        
        self.titleLabel.setContentHuggingPriority(1000, for: .vertical)
        self.authorLabel.setContentHuggingPriority(1000, for: .vertical)
        self.contentLabel.setContentHuggingPriority(1000, for: .vertical)
        
        self.titleLabel.setContentCompressionResistancePriority(750, for: .vertical)
        self.authorLabel.setContentCompressionResistancePriority(750, for: .vertical)
        self.contentLabel.setContentCompressionResistancePriority(750, for: .vertical)
        
//        self.bgImageView.setContentHuggingPriority(1000, for: .vertical)
//        self.bgImageView.setContentCompressionResistancePriority(50, for: .vertical)
        
        //test
//        self.titleLabel.backgroundColor = UIColor.green.withAlphaComponent(0.3)
//        self.authorLabel.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
//        self.contentLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
    }
    
    internal func setupSubviews() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.authorLabel)
        self.addSubview(self.contentLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgImageView.frame = self.bounds
        
        let resizedImage = self.resizedImage(size: self.bounds.size)
        self.bgImageView.image = resizedImage
    }
    
    internal func setupConstraints() {
        let verticalOffset = convertWidth(pix: 50)
        
        self.titleLabel.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(verticalOffset)
            
            make.width.lessThanOrEqualToSuperview()
            if self.textAlignment == .center {
                make.centerX.equalToSuperview().offset(contentHorizonalOffset)
            }
            else {
                make.left.equalToSuperview().offset(contentHorizonalOffset)
            }
        }
        
        self.authorLabel.snp.remakeConstraints { (make) in
            if self.textAlignment == .center {
                make.centerX.equalToSuperview().offset(contentHorizonalOffset)
            }
            else {
                make.left.equalToSuperview().offset(contentHorizonalOffset)
            }
            make.width.lessThanOrEqualToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(convertWidth(pix: 10))
            if self.authorLabel.isHidden {
                make.height.equalTo(0)
            }
        }
        
        self.contentLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(convertWidth(pix: 10))
            make.width.lessThanOrEqualToSuperview()
            if self.textAlignment == .center {
                make.centerX.equalToSuperview().offset(contentHorizonalOffset)
            }
            else {
                make.left.equalToSuperview().offset(contentHorizonalOffset)
            }
            
            make.bottom.equalToSuperview().offset(-verticalOffset).priority(750)
        }
        
        
    }
    
    public func setupData(title: String, author: String, content: String) {
        self.titleLabel.text = title
        self.authorLabel.text = author
        self.contentLabel.text = content
    }
    
    public func setupBGImage(image: UIImage) {
//        self.bgImageView.contentMode = contentMode
        //self.bgImageView.image = image
        self.bgImage = image
        self.setNeedsLayout()
    }
    
    public func increaseFontSize() {
        self.updateFont(pointSizeStep: increaseFontStep)
    }
    
    public func reduceFontSize() {
        self.updateFont(pointSizeStep: -increaseFontStep)
    }
    
    public func switchTextAlign() {
        if self.textAlignment == .center {
            self.textAlignment = .left
        }
        else {
            self.textAlignment = .center
        }
    }
    
    public func contentMoveLeft() {
        self.contentHorizonalOffset -= contentHorizonalMoveStep
        self.setupConstraints()
    }
    
    public func contentMoveRight() {
        self.contentHorizonalOffset += contentHorizonalMoveStep
        self.setupConstraints()
    }
    
    public func toggleAuthorHidden() {
        self.authorLabel.isHidden = !self.authorLabel.isHidden
        self.setupConstraints()
    }
    
    public func updateFont(pointSizeStep: CGFloat) {
        var pointSize = self.pointSize(with: self.titleLabel.font.pointSize, increaseSize: pointSizeStep)
        self.titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: pointSize)
        
        pointSize = self.pointSize(with: self.authorLabel.font.pointSize, increaseSize: pointSizeStep)
        self.authorLabel.font = UIFont(name: self.authorLabel.font.fontName, size: pointSize)
        
        pointSize = self.pointSize(with: self.contentLabel.font.pointSize, increaseSize: pointSizeStep)
        self.contentLabel.font = UIFont(name: self.contentLabel.font.fontName, size: pointSize)
    }
    
    internal func pointSize(with rawSize: CGFloat, increaseSize: CGFloat) -> CGFloat {
        let tarSize = rawSize + increaseSize
        if tarSize < minFontSize {
            return minFontSize
        }
        else if tarSize > maxFontSize {
            return maxFontSize
        }
        return tarSize
    }
    
    internal func resizedImage(size: CGSize) -> UIImage {
        if self.bgImage.size.width >= size.width && self.bgImage.size.height >= size.height {
            return self.bgImage
        }
        
        let ratio = fmax(size.height / self.bgImage.size.height, size.width / self.bgImage.size.width)
        
        let resizeSize = CGSize(width: self.bgImage.size.width * ratio, height: self.bgImage.size.height * ratio)
        
        return self.bgImage.imageScaledToSize(newSize: resizeSize)
    }
}

internal extension UIImage {
    func imageScaledToSize(newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        self.draw(in: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
