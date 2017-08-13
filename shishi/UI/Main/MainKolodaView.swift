//
//  MainKolodaView.swift
//  shishi
//
//  Created by tb on 2017/8/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

//主页视图封装，暂时未使用到
class MainKolodaView: UIView {
    
    fileprivate lazy var poetryView: PoetryScrollView = {
        let scrollView = PoetryScrollView()
        return scrollView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
        self.setupConstrains()
        
        self.poetryView.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        self.addSubview(self.poetryView)
    }
    
    fileprivate func setupConstrains() {
        self.poetryView.snp.makeConstraints { (make) in
            make.width.centerY.centerX.equalToSuperview()
            make.height.equalTo(self.poetryView.snp.width)
        }
    }
}
