//
//  VC.swift
//  shishi
//
//  Created by tb on 2017/5/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftyImage

//顶部上联和刷新视图背景色
private let containerViewColor = UIColor(intColor:0xf1f1f1)

private let cellReuseIdentifier = "cellReuseIdentifier"

class DuishiVC: UIViewController {
    
    var shangLianTF: UITextField!
    var searchBtn: UIButton!
    var refreshBtn: UIButton!
    
    //locker 文字的容器
    lazy var duishiEditView: DuishiEditView! = {
        let duishiEditView = DuishiEditView()
        self.lockerContainerView.addSubview(duishiEditView)
        duishiEditView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.refreshBtn.snp.left).offset(-20)
        }
        return duishiEditView
    }()
    
    
    //上联底部的分割线
    var separatorView: UIView!
    
    var xiaLianArray = [String]()
    
    //列表
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.lockerContainerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        return tableView
    }()
    
    lazy var lockerContainerView: UIView = self.createLockerContainerView()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(intColor:0xd8d8d8)
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //定制蓝底白字按钮
    private func setup(btn: UIButton, title: String) {
        let nomalImage = UIImage.size(CGSize(width: 1, height: 1))
            .color(SSTheme.Color.blueBtnNormal)
            .image
        
        let highlightedImage = UIImage.size(CGSize(width: 1, height: 1))
            .color(SSTheme.Color.blueBtnHighlighted)
            .image
        
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        
        btn.setBackgroundImage(nomalImage, for: .normal)
        btn.setBackgroundImage(highlightedImage, for: .highlighted)
        btn.setTitle(title, for: .normal)
    }
    
    //初始化界面
    private func setupUI() {
        let shangLianContainerView = UIView()
        self.view.addSubview(shangLianContainerView)
        shangLianContainerView.backgroundColor = containerViewColor
        shangLianContainerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.searchBtn = UIButton()
        shangLianContainerView.addSubview(self.searchBtn)
        
        self.setup(btn: self.searchBtn, title: SSStr.Duishi.duishi)
        self.searchBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalToSuperview().offset(-16)
        }
        self.searchBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onSearchBtnClicked()
            })
            .addDisposableTo(self.rx_disposeBag)
        
        self.shangLianTF = UITextField()
        shangLianContainerView.addSubview(self.shangLianTF)
        self.shangLianTF.backgroundColor = UIColor.white
        self.shangLianTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(self.searchBtn)
            make.centerY.equalToSuperview()
            make.right.equalTo(self.searchBtn.snp.left).offset(-20)
        }
        
        self.separatorView = UIView()
        self.view.addSubview(self.separatorView)
        self.separatorView.backgroundColor = SSTheme.Color.separator
        self.separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(shangLianContainerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(SSTheme.Dimens.separatorHeight)
        }
    }
    
    fileprivate func createLockerContainerView() -> UIView {
        let lockerView = UIView()
        self.view.addSubview(lockerView)
        lockerView.backgroundColor = containerViewColor
        lockerView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        })
        
        self.refreshBtn = UIButton()
        lockerView.addSubview(self.refreshBtn)
        self.setup(btn: self.refreshBtn, title: SSStr.Duishi.refresh)
        self.refreshBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalToSuperview().offset(-16)
        }
        self.refreshBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onRefreshBtnClicked()
            })
            .addDisposableTo(self.rx_disposeBag)
        
        
        
        return lockerView
    }
    
    
    //重置LOCKER内容
    fileprivate func resetLockerView() {
        self.duishiEditView.reset(itemCount: self.shangLianTF.text?.characters.count ?? 0)
    }
    
    //搜索按钮
    fileprivate func search(with shanglian: String, locker: String?, completed: @escaping (Bool) -> Void) {
        
        self.showProgressHUD()
        
        duishiNetwork().request(token: .xiaLian(shangLian: shanglian, locker: locker))
            .mapXiaLian()
            .do(onError: { [weak self] (error) in
                //self?.onError(error: error)
                log.debug(error)
                self?.hideProgressHUD()
                completed(false)
            })
            
            .subscribe (onNext : { [weak self] (objectArray) in
                //log.debug(objectArray)
                self?.hideProgressHUD()
                self?.xiaLianArray = objectArray
                completed(true)
                //self?.applaySearchResult(xianLianArray: objectArray)
            })
            .addDisposableTo(self.rx_disposeBag)
    }
    
    fileprivate func showCopyAlert(_ text: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let copyAction = UIAlertAction(title: "复制", style: .default) { action in
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = text
        }
        alert.addAction(copyAction)
        self.present(alert, animated: true)
    }
}


// MARK: - Action
extension DuishiVC {
    //搜索按钮
    fileprivate func onSearchBtnClicked() {
        guard let shanglian = self.shangLianTF.text, !shanglian.isEmpty else {
            return
        }
        
        self.search(with: shanglian, locker: nil) { isSuccess in
            self.tableView.reloadData()
            self.resetLockerView()
        }
    }

    //刷新按钮
    fileprivate func onRefreshBtnClicked() {
        guard let shanglian = self.shangLianTF.text, !shanglian.isEmpty else {
            return
        }
        
        var locker = self.duishiEditView.currentText()
        
        //有可能是删除或者增加了上联导致上联长度和LOCKER长度不一致
        if locker?.characters.count != shanglian.characters.count {
            self.resetLockerView()
            locker = self.duishiEditView.currentText()
        }
        
        self.search(with: shanglian, locker: locker) { isSuccess in
            self.tableView.reloadData()
        }
    }
    
}



// MARK: - UITableViewDataSource
extension DuishiVC : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.xiaLianArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = self.xiaLianArray[indexPath.row]
        return cell
    }
}


// MARK: - UITableViewDelegate
extension DuishiVC: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
        
        let dataString = self.xiaLianArray[indexPath.row]
        self.showCopyAlert(dataString)
    }
}
