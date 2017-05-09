//
//  SettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/10.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

import UIKit


class SettingVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    static let itemHeight=45
    
    func setupUI(){
        
//        let back = UIImageView()
//        back.image=UIImage(named:"launch_image")
//        self.view.sendSubview(toBack:back)
//        back.snp.makeConstraints{ (make) in
//            make.left.top.right.bottom.equalToSuperview()
//        }

        
        let backgroundView = UIImageView()
        backgroundView.image=UIImage(named:"launch_image")
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{ (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        
        let contentView=UIView()
        contentView.backgroundColor=SSTheme.Color.settingBack
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 3

        self.view.addSubview(contentView)
        contentView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(SettingVC.itemHeight*2)
        }
        
        
        let yun = UIView()
                contentView.addSubview(yun)
        yun.snp.makeConstraints{ (make) in
            make.height.equalTo(SettingVC.itemHeight)
            make.top.left.right.equalToSuperview()
        }
        let yunTitle = UILabel()
        yunTitle.text = SSStr.YUN_TITLE
        yun.addSubview(yunTitle)
        yunTitle.snp.makeConstraints{ (make) in
           make.left.equalToSuperview().offset(20)
           make.centerY.equalToSuperview()
        }
        
        let yunHint = UILabel()
        yunHint.text = SSStr.YUN_TITLE
        yun.addSubview(yunHint)
        yunHint.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    
}
