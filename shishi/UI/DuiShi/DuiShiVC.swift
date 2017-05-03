//
//  DuiShiVC.swift
//  shishi
//
//  Created by tb on 2017/5/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DuiShiVC: UIViewController {
    
    var searchTF: UITextField!
    var searchBtn: UIButton!
    var refreshBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.gray
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupUI() {
        let searchContainerView = UIView()
        self.view.addSubview(searchContainerView)
        searchContainerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.searchBtn = UIButton()
        searchContainerView.addSubview(self.searchBtn)
        self.searchBtn.tintColor = UIColor.blue
        self.searchBtn.setTitle(SSStr.DuiShi.duiShi, for: .normal)
        self.searchBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalToSuperview().offset(-16)
        }
        self.searchBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onSearchBtnClicked()
            })
            .addDisposableTo(self.rx_disposeBag)
        
        self.searchTF = UITextField()
        searchContainerView.addSubview(self.searchTF)
        self.searchTF.backgroundColor = UIColor.white
        self.searchTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(self.searchBtn)
            make.centerY.equalToSuperview()
            make.right.equalTo(self.searchBtn.snp.left).offset(-20)
        }
    }

    private func onSearchBtnClicked() {
        
    }

}
