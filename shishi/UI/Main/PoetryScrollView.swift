//
//  PoetryScrollView.swift
//  shishi
//
//  Created by tb on 2017/8/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

//主页视图封装，暂时未使用到
class PoetryScrollView: UIView {
    
    var contentText: String? {
        get {
            return self.poetryView.contentLabel.text
        }
        set {
            self.poetryView.contentLabel.text = contentText
        }
    }
    
    internal lazy var poetryScrollView: UIScrollView = {
        let poetryScrollView = UIScrollView()
        return poetryScrollView
    }()
    
    internal lazy var poetryView: SharePoetryView = {
        let poetryContainerView = SharePoetryView(frame: CGRect.zero)
        return poetryContainerView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.addSubview(self.poetryScrollView)
        self.poetryScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.poetryScrollView.snp.width)
        }
        
        self.poetryScrollView.addSubview(self.poetryView)
        
        self.poetryView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
    }
    
    
}
