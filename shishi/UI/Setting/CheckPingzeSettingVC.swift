//
//  CheckPingzeSettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class CheckPingzeSettingVC : BaseSettingVC {
    
    var changeSelector: (() -> Void)!
    
    var itemList = [SettingCheckItemView]()
    
    let itemClickSelectors = [#selector(itemClickSelector1),#selector(itemClickSelector2)]
    
    override func setupUI() {
        
        let card = getCardView()
        self.scrollView.addSubview(card)
        card.snp.makeConstraints{ (make) in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(backBtn).offset(TOP_OFFSET)
            make.height.equalTo(ITEM_HEIGHT * itemClickSelectors.count)
            
        }
        
        for (index,itemClickSelector) in itemClickSelectors.enumerated() {
            let item = SettingCheckItemView()
            itemList.append(item)
            card.addSubview(item)
            item.snp.makeConstraints{ (make) in
                make.left.right.equalToSuperview()
                if index == 0 {
                    make.top.equalToSuperview()
                }
                else{
                    make.top.equalTo(itemList[index-1].snp.bottom).offset(1)
                }
                make.height.equalTo(ITEM_HEIGHT)
            }
            item.title.text = SSStr.Setting.CHECK_CHOICES[index]
            item.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: itemClickSelector)
            item.addGestureRecognizer(tapGes)
            
            if index != itemClickSelectors.count-1 {
                addDivideView(card,topView:item)
            }
            
        }
        
        refreshCheck()
    }
    
    func refreshCheck(){
        let check = UserDefaultUtils.getCheckPingze()
        for (index,item) in itemList.enumerated() {
            if index == check {
                item.checkView.isHidden = false
            }
            else{
                item.checkView.isHidden = true
            }
        }
    }
    
    
    func itemClickSelector1(){
        changeSelector(0)
    }
    func itemClickSelector2(){
        changeSelector(1)
    }
    
    func changeSelector(_ index: Int) {
        UserDefaultUtils.setCheckPingze(index)
        refreshCheck()
        changeSelector()
    }
    
    override func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
