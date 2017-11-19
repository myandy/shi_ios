//
//  AuthorCellVC.swift
//  shishi
//
//  Created by andymao on 2017/8/1.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class AuthorCellVC : UIViewController {
    
    
    lazy var titleLabel: UILabel! = {
        var titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 34)
        titleLabel.snp.makeConstraints{ (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.width.equalTo(40)
        }
        return titleLabel
    }()
    
    
    lazy var scrollView: UIScrollView! = {
        var scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.isPagingEnabled = false
        scrollView.alwaysBounceVertical = true
        scrollView.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(70)
            make.right.equalTo(self.titleLabel.snp.left)
        }
        return scrollView
    }()
    
    lazy var introLabel: UILabel! = {
        var introLabel = UILabel()
        introLabel.font = UIFont.systemFont(ofSize: 15)
        introLabel.textColor = UIColor.white
        self.scrollView.addSubview(introLabel)
        introLabel.numberOfLines = 0
        introLabel.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
            make.right.equalTo(self.titleLabel.snp.left).offset(-10)
        }
        return introLabel

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }
    

    init(author:Author) {
        super.init(nibName: nil, bundle: nil)

        self.titleLabel.text = author.name
        self.introLabel.text = author.intro

        
        FontsUtils.setFont(self.view)
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateFont(pointSizeStep: CGFloat) {
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.titleLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.introLabel)
        
    }
    
    fileprivate func updateFont(pointSizeStep: CGFloat, label: UILabel) {
        label.font = UIFont(name: label.font.fontName, size: label.font.pointSize + pointSizeStep)
    }
    
    
}
