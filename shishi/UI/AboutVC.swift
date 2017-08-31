//
//  AboutVC.swift
//  shishi
//
//  Created by andymao on 2017/6/14.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class AboutVC: BaseSettingVC {
    
    
    override func setupUI() {
        
        let aboutTitle = UILabel()
        self.view.addSubview(aboutTitle)
        aboutTitle.font = UIFont.systemFont(ofSize: 26)
        aboutTitle.text = SSStr.Setting.ABOUT_LABEL
        aboutTitle.textColor = SSTheme.Color.whiteHint
        aboutTitle.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(backBtn.snp.bottom).offset(30)
        }
        
        
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let version = SSStr.Setting.ABOUT_VERSION.appending(currentVersion)
        let itemTexts = [version,SSStr.Setting.ABOUT_QQ,SSStr.Setting.ABOUT_WEXIN,SSStr.Setting.ABOUT_EMAIL,SSStr.Setting.ABOUT_INTRO]
        var itemList=[UIView]()
        
        for (index,itemText) in itemTexts.enumerated() {
            
            let item = getCardView()
            itemList.append(item)
            
            let title = TouchEffectLabel()
            title.numberOfLines = 0
            title.textColor = UIColor.white
            title.attributedText = getAttributeStringWithString(itemText, lineSpace: 10)
            
            item.addSubview(title)
            title.snp.makeConstraints{ (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            scrollView.addSubview(item)
            item.snp.makeConstraints{ (make) in
                make.left.equalToSuperview().offset(20)
                make.right.equalTo(self.view).offset(-20)
                
                if index == 0 {
                    make.top.equalTo(aboutTitle.snp.bottom).offset(40)
                }
                else{
                    make.top.equalTo(itemList[index-1].snp.bottom).offset(20)
                }
                
            }
            
            if index == 3 {
                
                let string              = itemText
                let range               = (string as NSString).range(of: SSStr.Setting.ABOUT_EMAIL_VALUE)
                let attributedString    = NSMutableAttributedString(string: string)
                
                attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: 1), range: range)
                
                
                let paragraphStye = NSMutableParagraphStyle()
                paragraphStye.lineSpacing = 10
                let rang = NSMakeRange(0, CFStringGetLength(string as CFString!))
                attributedString .addAttribute(NSParagraphStyleAttributeName, value: paragraphStye, range: rang)
                title.attributedText = attributedString
                
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(emailClicked))
                title.addGestureRecognizer(tapGes)
            }
            
        }
        
    }
    
    func emailClicked(){
        UIApplication.shared.open(URL(string: "mailto://".appending(SSStr.Setting.ABOUT_EMAIL_VALUE))!)
    }
    
    
    //返回按钮
    override func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
    fileprivate func getAttributeStringWithString(_ string: String,lineSpace:CGFloat
        ) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(string as CFString!))
        attributedString .addAttribute(NSParagraphStyleAttributeName, value: paragraphStye, range: rang)
        return attributedString
        
    }
    
    
}
