//
//  YunSettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/22.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class YunSettingVC : BaseSettingVC {
    
    var changeSelector: (() -> Void)!
    
    var itemList = [SettingCheckItemView]()
    
    let itemClickSelectors = [#selector(itemClickSelector1),#selector(itemClickSelector2),#selector(itemClickSelector3)]
    
    override func setupUI() {
        
        let card = getCardView()
        self.scrollView.addSubview(card)
        card.snp.makeConstraints{ (make) in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(backBtn).offset(TOP_OFFSET)
            make.height.equalTo(ITEM_HEIGHT * 3)
            
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
            item.title.text = SSStr.Setting.YUN_CHOICES[index]
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
        let check = UserDefaultUtils.getYunshu()
        for i in 0...2 {
            if i == check {
                itemList[i].checkView.isHidden = false
            }
            else{
                itemList[i].checkView.isHidden = true
            }
        }
    }
    
    
    func itemClickSelector1(){
        changeSelector(0)
    }
    func itemClickSelector2(){
        changeSelector(1)
    }
    func itemClickSelector3(){
        changeSelector(2)
    }
    
    func changeSelector(_ pos: Int) {
        UserDefaultUtils.setYunshu(pos)
        refreshCheck()
        changeSelector()
    }
    
    override func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
