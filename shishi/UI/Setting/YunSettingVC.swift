//
//  YunSettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/22.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class YunSettingVC : BaseSettingVC {
    
    var changeYun: (() -> Void)!
    
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
        
        for i in 0...2 {
            let yunItem = SettingCheckItemView()
            itemList.append(yunItem)
            card.addSubview(yunItem)
            yunItem.snp.makeConstraints{ (make) in
                make.left.right.equalToSuperview()
                if i == 0 {
                    make.top.equalToSuperview()
                }
                else{
                    make.top.equalTo(itemList[i-1].snp.bottom).offset(1)
                }
                make.height.equalTo(ITEM_HEIGHT)
            }
            
            yunItem.title.text = SSStr.Setting.YUN_CHOCICIES[i]
            yunItem.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: itemClickSelectors[i])
            yunItem.addGestureRecognizer(tapGes)
            
            if 1 != 2 {
                addDivideView(card,topView:yunItem)
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
        changeYun()
    }
    
}
