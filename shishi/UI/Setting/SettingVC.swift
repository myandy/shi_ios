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
    
    lazy var scrollView: UIScrollView! = {
        var scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.alwaysBounceVertical = true
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
        }
        return scrollView
    }()
    
    lazy var backBtn: UIButton! = {
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named:"back"), for: .normal)
        self.scrollView.addSubview(backBtn)
        backBtn.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(backBtn.snp.height)
            
        }
        backBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onBackBtnClicked()
            })
            .addDisposableTo(self.rx_disposeBag)
        return backBtn
    }()
    
    
    func setupUI(){
        addBackgroundImage()

        
        let card1 = getCardView()
        self.scrollView.addSubview(card1)
        card1.snp.makeConstraints{ (make) in
            make.left.equalTo(scrollView).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(backBtn).offset(80)
            make.height.equalTo(ITEM_HEIGHT * 2)

        }

        let yunItem = SettingItemView()
        card1.addSubview(yunItem)
        yunItem.snp.makeConstraints{ (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(ITEM_HEIGHT)
        }
        yunItem.title.text = SSStr.Setting.YUN_TITLE
        yunItem.hint.text = SSStr.Setting.YUN_TITLE
        yunItem.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.yunItemClick(_:)))
        yunItem.addGestureRecognizer(tapGes)
        

        addDivideView(card1,topView:yunItem)
        
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
    
    
    func getCardView()->UIView{
        let cardView = UIView()
        cardView.backgroundColor = SSTheme.Color.settingBack
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 5
        return cardView
    }
  
    
}

// MARK: - Action
extension SettingVC{
    //返回按钮
    fileprivate func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }

    
    func yunItemClick(_ sender: Any){
        //        self.navigationController?.popViewController(animated: true)
    }
    
}


