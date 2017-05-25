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
    
    lazy var fontItem: SettingItemView = SettingItemView()
    
    lazy var checkPingzeItem: SettingItemView = SettingItemView()
    
    lazy var selectorList = [#selector(yunItemClick),#selector(fontItemClick),#selector(checkItemClick)]
    
    lazy var titleList = [SSStr.Setting.YUN_TITLE,SSStr.Setting.FONT_TITLE,SSStr.Setting.CHECK_TITLE]
    
    override func setupUI(){
        
        let card1 = getCardView()
        self.scrollView.addSubview(card1)
        var itemList = [yunItem,fontItem,checkPingzeItem]

        card1.snp.makeConstraints{ (make) in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(backBtn).offset(80)
            make.height.equalTo(ITEM_HEIGHT * itemList.count)
        }
        
        for (index,item) in itemList.enumerated() {
            card1.addSubview(item)
            
            item.snp.makeConstraints{ (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(ITEM_HEIGHT)
                if index == 0 {
                    make.top.equalToSuperview()
                }
                else {
                    make.top.equalTo(itemList[index-1].snp.bottom).offset(1)
                }
            }
            item.title.text = titleList[index]
            item.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: selectorList[index])
            item.addGestureRecognizer(tapGes)
            if index > 0 && index < itemList.count {
                addDivideView(card1,topView:itemList[index-1])
            }
            
        }
        
        
        refreshYun()
        refreshFont()
        refreshCheckPingze()
        
    }
    
    func refreshYun(){
        self.yunItem.hint.text = SSStr.Setting.YUN_CHOICES[UserDefaultUtils.getYunshu()]
    }
    
    func refreshFont(){
        self.fontItem.hint.text = SSStr.Setting.FONT_CHOICES[UserDefaultUtils.getFont()]
    }
    
    func refreshCheckPingze(){
        self.checkPingzeItem.hint.text = SSStr.Setting.CHECK_CHOICES[UserDefaultUtils.getCheckPingze()]
    }
    
    override func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Action
extension SettingVC{
    
    
    func yunItemClick(){
        let vc = YunSettingVC()
        vc.changeSelector = { () in
            self.refreshYun()
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func fontItemClick(){
        let vc = FontSettingVC()
        vc.changeSelector = { () in
            self.refreshFont()
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func checkItemClick(){
        let vc = CheckPingzeSettingVC()
        vc.changeSelector = { () in
            self.refreshCheckPingze()
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
  
}


