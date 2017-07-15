//
//  ShareVC.swift
//  shishi
//
//  Created by tb on 2017/7/13.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift
import Photos

class ShareVC: UIViewController {
    
    var poetry:Poetry!
    
    //背景图片
    internal var bgImage:UIImage!
    
    internal lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launch_image"))
        return imageView
    }()
    
    internal lazy var bottomBar: UIView = {
        let bottomBar = UIView()
        return bottomBar
    }()
    
    internal lazy var poetryScrollView: UIScrollView = {
        let poetryScrollView = UIScrollView()
        return poetryScrollView
    }()
    
    internal lazy var poetryContainerView: SharePoetryView = {
        let poetryContainerView = SharePoetryView(frame: CGRect.zero)
        return poetryContainerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.poetryContainerView.setupData(title: self.poetry.title, author: self.poetry.author, content: self.poetry.poetry)
        self.poetryContainerView.setupBGImage(image: self.bgImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func setupUI() {
        self.setupViews()
        self.setupConstraints()
        
        self.setupPoetryView()
    }
    
    internal func setupViews() {
        
        self.view.addSubview(self.bgImageView)
        
        self.view.addSubview(self.poetryScrollView)
        
        self.setupBottomView()
    }
    
    internal func setupPoetryView() {
        self.poetryScrollView.addSubview(self.poetryContainerView)
        
        self.poetryContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.height.greaterThanOrEqualToSuperview()
        }
    }
    
    internal func setupBottomView() {
        self.view.addSubview(self.bottomBar)
        
        let cancleBtn = UIButton()
        self.bottomBar.addSubview(cancleBtn)
        cancleBtn.setImage(UIImage(named:"cancel"), for: .normal)
        cancleBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(convertWidth(pix: 20))
            make.bottom.equalToSuperview().offset(convertWidth(pix: -20))
            make.height.width.equalTo(convertWidth(pix: 90))
        }
        cancleBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            })
            .addDisposableTo(self.rx_disposeBag)
        
        let editBtn = UIButton()
        self.bottomBar.addSubview(editBtn)
        editBtn.setImage(UIImage(named:"setting"), for: .normal)
        editBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(convertWidth(pix: -20))
            make.bottom.height.width.equalTo(cancleBtn)
        }
        editBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onEditBtnClidk()
            })
            .addDisposableTo(self.rx_disposeBag)
        
        let shareBtn = UIButton()
        self.bottomBar.addSubview(shareBtn)
        shareBtn.setImage(UIImage(named:"share3"), for: .normal)
        shareBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(cancleBtn)
            make.right.equalTo(editBtn.snp.left).offset(convertWidth(pix: -20))
        }
        shareBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onShareBtnClidk()
            })
            .addDisposableTo(self.rx_disposeBag)
        
    }
    
    internal func setupConstraints() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.poetryScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(convertWidth(pix: 100))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.height.equalTo(self.poetryScrollView.snp.width)
        }
        
        self.bottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(convertWidth(pix: 100))
        }
    }
}

//action
extension ShareVC {
    internal func onEditBtnClidk() {
        let alertController = UIAlertController(title: SSStr.Share.SHARE, message: nil, preferredStyle: .actionSheet)
        //定义取消按钮及事件
        let cancelAction = UIAlertAction(title: SSStr.Common.CANCEL, style: .cancel, handler: {
            (UIAlertAction)->Void in
        })
        
        let increaseAction = UIAlertAction(title: SSStr.Share.INCREASE_FONTSIZE, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.increaseFontSize()
        })
        
        let reduceAction = UIAlertAction(title: SSStr.Share.REDUCE_FONTSIZE, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.reduceFontSize()
        })
        
        let alignAction = UIAlertAction(title: SSStr.Share.TEXT_ALIGN, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.switchTextAlign()
        })
        
        let moveLeftAction = UIAlertAction(title: SSStr.Share.CONTENT_MOVELEFT, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.contentMoveLeft()
        })
        
        let moveRightAction = UIAlertAction(title: SSStr.Share.CONTENT_MOVERIGHT, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.contentMoveRight()
        })
        
//        let fontColorAction = UIAlertAction(title: SSStr.Share.HIDE_AHTHOR, style: .default, handler:{ [unowned self]
//            (UIAlertAction) -> Void in
//            //self.poetryContainerView.toggleAuthorHidden()
//        })
        
        let hideAuthorAction = UIAlertAction(title: SSStr.Share.HIDE_AHTHOR, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            self.poetryContainerView.toggleAuthorHidden()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(increaseAction)
        alertController.addAction(reduceAction)
        alertController.addAction(alignAction)
        alertController.addAction(moveLeftAction)
        alertController.addAction(moveRightAction)
//        alertController.addAction(fontColorAction)
        alertController.addAction(hideAuthorAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    internal func onShareBtnClidk() {
        let alertController = UIAlertController(title: SSStr.Share.SHARE, message: nil, preferredStyle: .actionSheet)
        //定义取消按钮及事件
        let cancelAction = UIAlertAction(title: SSStr.Common.CANCEL, style: .cancel, handler: {
            (UIAlertAction)->Void in
        })
        
        let copyAction = UIAlertAction(title: SSStr.Share.COPY_TEXT, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = self.poetry.title + "\n" + self.poetry.author + "\n" + self.poetry.poetry
        })
        
        let saveImageAction = UIAlertAction(title: SSStr.Share.SAVE_IMAGE, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            let image = SSImageUtil.image(with: self.poetryContainerView)
            PHPhotoLibrary.shared().performChanges({ 
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { (success, error) in
                if success {
                    self.showToast(message: SSStr.Share.SAVE_SUC)
                }
                else {
                    self.showToast(message: SSStr.Share.SAVE_FAIL)
                }
            })
        })
        
        let shareImageAction = UIAlertAction(title: SSStr.Share.SHARE, style: .default, handler:{ [unowned self]
            (UIAlertAction) -> Void in
            let image = SSImageUtil.image(with: self.poetryContainerView)
            SSShareUtil.default.shareToSystem(controller: self, image: image)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(copyAction)
        alertController.addAction(saveImageAction)
        alertController.addAction(shareImageAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
