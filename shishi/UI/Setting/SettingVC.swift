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
    
    lazy var authorItem: SettingItemView = SettingItemView()
    
    lazy var selectorList = [#selector(yunItemClick),#selector(fontItemClick),#selector(checkItemClick),#selector(writingItemClick)]
    
    lazy var titleList = [SSStr.Setting.YUN_TITLE,SSStr.Setting.FONT_TITLE,SSStr.Setting.CHECK_TITLE,SSStr.Setting.AUTHOR_TITLE]
    
    lazy var selectorList2 = [#selector(aboutItemClick),#selector(marktemClick),#selector(weiboItemClick)]
    
    lazy var titleList2 = [SSStr.Setting.ABOUT_TITLE,SSStr.Setting.MARK_TITLE,SSStr.Setting.WEIBO_TITLE]
    
    override func setupUI(){
        SSNotificationCenter.default.rx.notification(SSNotificationCenter.Names.updateAppLanguage).subscribe(onNext: { [weak self] notify in
            self?.refreshFont()
        })
        .addDisposableTo(self.rx_disposeBag)
        
        let card1 = getCardView()
        self.scrollView.addSubview(card1)
        var itemList = [yunItem,fontItem,checkPingzeItem,authorItem]

        card1.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
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
        refreshUsername()
        
        let card2 = getCardView()
        self.scrollView.addSubview(card2)
        var itemList2 = [SettingItemView(),SettingItemView(),SettingItemView()]

        card2.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(card1.snp.bottom).offset(20)
            make.height.equalTo(ITEM_HEIGHT * itemList2.count)
        }
        for (index,item) in itemList2.enumerated() {
            card2.addSubview(item)
            item.snp.makeConstraints{ (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(ITEM_HEIGHT)
                if index == 0 {
                    make.top.equalToSuperview()
                }
                else {
                    make.top.equalTo(itemList2[index-1].snp.bottom).offset(1)
                }
            }
            item.title.text = titleList2[index]
            item.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: selectorList2[index])
            item.addGestureRecognizer(tapGes)
            if index > 0 && index < itemList.count {
                addDivideView(card2,topView:itemList2[index-1])
            }
        }

        
    }
    
    func refreshYun(){
        self.yunItem.hint.text = SSStr.Setting.YUN_CHOICES[UserDefaultUtils.getYunshu()]
    }
    
    func refreshFont(){
        self.fontItem.hint.text = SSStr.Setting.FONT_CHOICES[UserDefaultUtils.getFont()]
    }
    
    func refreshCheckPingze(){
        self.checkPingzeItem.hint.text = SSStr.Setting.CHECK_CHOICES[UserDefaultUtils.isCheckPingze() ? 0 : 1]
    }
    
    func refreshUsername(){
        self.authorItem.hint.text = UserDefaultUtils.getUsername()
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
    
    func writingItemClick(){
        let alert = UIAlertController(title: SSStr.Setting.USERNAME_TITLE, message: SSStr.Setting.USERNAME_CONTENT, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
            let username = UserDefaultUtils.getUsername()
            if username != nil && !(username?.isEmpty)! {
                textField.text = username
            }
            textField.placeholder = SSStr.Setting.USERNAME_HINT
        }
        let alertView1 = UIAlertAction(title: SSStr.Common.CANCEL, style: UIAlertActionStyle.cancel)
        
        let alertView2 = UIAlertAction(title: SSStr.Common.CONFIRM, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            UserDefaultUtils.setUsername((alert.textFields?.first?.text)!)
            self.refreshUsername()
            SSNotificationCenter.default.post(name: SSNotificationCenter.Names.updateAuthorName, object: nil)
        }
        alert.addAction(alertView1)
        alert.addAction(alertView2)

        self.present(alert, animated: true, completion: nil)
    }
    
    func aboutItemClick(){
        self.navigationController?.pushViewController(AboutVC(), animated: false)
    }
    
    func marktemClick(){
        let urlString = "itms-apps://itunes.apple.com/app/id444934666"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!)
    }
    
    func weiboItemClick(){
        UIApplication.shared.open(URL(string: "http://www.weibo.com/anddymao")!)
    }
  
}


