//
//  BaseSearchVC.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import NSObject_Rx

class BaseSearchVC: UIViewController {
    
    lazy var cancelBtn: UIButton! = {
        let cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(named:"cancel"), for: .normal)
        self.view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.equalTo(SEARCH_BAR_HEIGHT)
            make.left.equalToSuperview()
            make.width.equalTo(cancelBtn.snp.height)
        }
        cancelBtn.addTapHandler(handle: { [unowned self] in
            self.onBackBtnClicked()
        })
        
        return cancelBtn
    }()
    
    
    lazy var searchBar: UISearchBar! = {
        let searchBar = UISearchBar()
        self.view.addSubview(searchBar)
        searchBar.barTintColor = UIColor(hex6: SSTheme.ColorInt.BACK)
        searchBar.backgroundImage = UIImage()
        searchBar.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.height.equalTo(SEARCH_BAR_HEIGHT)
            make.left.equalTo(self.cancelBtn.snp.right)
        }
        return searchBar
    }()
    
    lazy var lineView: UIView! = {
        let lineView = UIView()
        lineView.backgroundColor = SSTheme.Color.divideColor
        self.view.addSubview(lineView)
        lineView.snp.makeConstraints{ (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        return lineView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = SSTheme.Color.backColor
    }
    
    func hideKeyboardTapGesture(_ sender : Any){
        searchBar.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

// MARK: - Action
extension BaseSearchVC{
    //返回按钮
    fileprivate func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

