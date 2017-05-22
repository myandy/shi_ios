//
//  BaseSettingVC.swift
//  shishi
//
//  Created by andymao on 2017/5/22.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import NSObject_Rx

let ITEM_HEIGHT = 45

let TOP_OFFSET = 60

class BaseSettingVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        self.setupUI()
    }
    
    func setupUI(){
       
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
    


    //返回按钮
    fileprivate func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}
