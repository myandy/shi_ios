//
//  SettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/10.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import NSObject_Rx




class SettingVC: BaseSettingVC {
    
    
    lazy var yunItem: SettingItemView = SettingItemView()
    
    override func setupUI(){
        
        let card1 = getCardView()
        self.scrollView.addSubview(card1)
        card1.snp.makeConstraints{ (make) in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(backBtn).offset(80)
            make.height.equalTo(ITEM_HEIGHT * 2)
            
        }
        
        card1.addSubview(yunItem)
        yunItem.snp.makeConstraints{ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(ITEM_HEIGHT)
        }
        yunItem.title.text = SSStr.Setting.YUN_TITLE
        yunItem.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.yunItemClick(_:)))
        yunItem.addGestureRecognizer(tapGes)
        refreshYun()
        
        addDivideView(card1,topView:yunItem)
        
    }
    
    func refreshYun(){
        self.yunItem.hint.text = SSStr.Setting.YUN_CHOCICIES[UserDefaultUtils.getYunshu()]
    }
    
}

// MARK: - Action
extension SettingVC{
    
    
    func yunItemClick(_ sender: Any){
        let vc = YunSettingVC()
        vc.changeYun =
            {
                () in
                self.refreshYun()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


