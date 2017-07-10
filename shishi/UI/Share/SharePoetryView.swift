//
//  SharePoetryView.swift
//  shishi
//
//  Created by tb on 2017/7/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SharePoetryView: UIView {
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
        
        self.titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        self.authorLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        self.contentLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
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
    
    internal func setupConstraints() {
        
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().priority(750)
        }
        
        let verticalOffset = convertWidth(pix: 50)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(verticalOffset)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        }
        
        self.authorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(convertWidth(pix: 10))
        }
        
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authorLabel.snp.bottom).offset(convertWidth(pix: 10))
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            
            make.bottom.equalToSuperview().offset(-verticalOffset).priority(750)
        }
        
        
    }
    
    public func setupData(title: String, author: String, content: String) {
        self.titleLabel.text = title
        self.authorLabel.text = author
        self.contentLabel.text = content
    }
    
    public func setupBGImage(image: UIImage) {
        self.bgImageView.image = image
    }
}
