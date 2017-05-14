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


private let ITEM_HEIGHT=45

class SettingVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    

    
    
    func setupUI(){
        addBackgroundImage()
        addBackBtn()
        
        let card1 = getCardView()
        self.view.addSubview(card1)
        card1.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(ITEM_HEIGHT * 2)
        }

        let yunItem = getItemView(SSStr.Setting.YUN_TITLE, hint: SSStr.Setting.YUN_TITLE)
        card1.addSubview(yunItem.item)
        yunItem.item.snp.makeConstraints{ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(ITEM_HEIGHT)
        }
//        yunItem.item.rx.tap
//            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] in
//                self.onBackBtnClicked()
//            })
//            .addDisposableTo(self.rx_disposeBag)

        addDivideView(card1,topView:yunItem.item)
        
    }
    
    func addDivideView(_ subview:UIView,topView:UIView){
        let divideView = UIView()
        divideView.backgroundColor = SSTheme.Color.settingLine
        subview.addSubview(divideView)
        divideView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(topView.snp.bottom)
        }

    }
    
    
    func addBackBtn(){
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named:"back"), for: .normal)
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(backBtn.snp.height)

        }
        backBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onBackBtnClicked()
            })
            .addDisposableTo(self.rx_disposeBag)
    }
    
    func getCardView()->UIView{
        let cardView = UIView()
        cardView.backgroundColor = SSTheme.Color.settingBack
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 3
        return cardView
    }
    
    func getItemView(_ title:String,hint:String) -> SettingItem{
        
        let item = SettingItem()
        item.item = UIView()
        let itemView = item.item!
        
        item.title = UIButton()
        item.title.titleLabel?.textColor = UIColor.white
        item.title.setTitle(title, for: .normal)
        itemView.addSubview(item.title)
        item.title.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        item.hint = UILabel()
        item.hint.text = hint
        item.hint.textColor = UIColor.white
        itemView.addSubview(item.hint)
        item.hint.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }

        return item
    }
    

    
}

// MARK: - Action
extension SettingVC{
    //返回按钮
    fileprivate func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}

class SettingItem {
    var item: UIView!
    var title: UIButton!
    var hint: UILabel!
}

