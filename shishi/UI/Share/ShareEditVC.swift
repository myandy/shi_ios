//
//  ShareEditVC.swift
//  shishi
//
//  Created by andymao on 2017/6/4.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift




class ShareEditVC : EditBGImageVC {
    //var poetry:Poetry!
    var poetryTitle: String!
    var poetryAuthor: String!
    var poetryContent: String!
    
    internal lazy var bottomBar: UIView = {
       let bottomBar = UIView()
        return bottomBar
    }()
    
    internal lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launch_image"))
        return imageView
    }()
    
    internal lazy var paperBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "share_btn_paper_n"), for: .normal)
        btn.setImage(UIImage(named: "share_btn_paper_s"), for: .selected)
        btn.isSelected = true
        return btn
    }()
    
    internal lazy var albumBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "share_btn_album_n"), for: .normal)
        btn.setImage(UIImage(named: "share_btn_album_s"), for: .selected)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //self.poetryContainerView.setupData(title: self.poetry.title, author: self.poetry.author, content: self.poetry.poetry)
        self.poetryContainerView.setupData(title: self.poetryTitle, author: self.poetryAuthor, content: self.poetryContent)
//        self.poetryContainerView.updateTextColor(textColor: UIColor(hexColor: "A9A9AB"))
        
        
        
        
        
    }
    
    override func tapHandler() {
        if self.albumBtn.isSelected {
            self.selectImage()
        }
        
    }
 
    
    
    internal override func setupUI() {
        super.setupUI()
    }
    
    internal override func setupViews() {
        self.view.addSubview(self.bgImageView)
        
        super.setupViews()
        
        
        self.setupBottomView()
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
        cancleBtn.addTapHandler { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        let confirmBtn = UIButton()
        self.bottomBar.addSubview(confirmBtn)
        confirmBtn.setImage(UIImage(named:"done"), for: .normal)
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(convertWidth(pix: -20))
            make.bottom.height.width.equalTo(cancleBtn)
        }
        confirmBtn.addTapHandler { [unowned self] in
            self.onConfirmBtnClick()
        }
        
        self.bottomBar.addSubview(self.paperBtn)
        self.paperBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(cancleBtn)
            make.right.equalTo(self.bottomBar.snp.centerX)
        }
        self.paperBtn.addTapHandler { [unowned self] in
            self.onPaperBtnClick()
        }
        
        self.bottomBar.addSubview(self.albumBtn)
        self.albumBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(cancleBtn)
            make.left.equalTo(self.paperBtn.snp.right)
        }
        self.albumBtn.addTapHandler { [unowned self] in
            self.onAlbumBtnClick()
        }
    }
    
    
    
    
    internal override func setupConstraints() {
        super.setupConstraints()
        
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        self.bottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.collectionView.snp.bottom)
        }
    }
    
    
    
    
}

//action
extension ShareEditVC {
    internal func onConfirmBtnClick() {
//        let bgImage = self.poetryContainerView.bgImageView.image!
//        let shareImage = SSImageUtil.genShiImage(bgImage, self.poetry.title, content: self.poetry.poetry)
//        SSShareUtil.default.shareToSystem(controller: self, image: shareImage)
        
//        let shareController = ShareVC()
//        shareController.poetryTitle = self.poetryTitle
//        shareController.poetryAuthor = self.poetryAuthor
//        shareController.poetryContent = self.poetryContent
//        shareController.bgImage = self.poetryContainerView.bgImageView.image
//        self.navigationController?.pushViewController(shareController, animated: true)
        
        //关闭当前页面
        CATransaction.begin()
        CATransaction.setCompletionBlock { [unowned self] in
            let index = self.navigationController?.viewControllers.index(of: self)!
            self.navigationController?.viewControllers.remove(at: index!)
        }
        let isAlbumImage = self.albumBtn.isSelected
        SSControllerHelper.showShareContoller(controller: self, poetryTitle: self.poetryTitle, poetryAuthor: self.poetryAuthor, poetryContent: self.poetryContent, bgImage: self.poetryContainerView.bgImageView.image, isAlbumImage: isAlbumImage)
        
        CATransaction.commit()
        
    }
    
    internal func onPaperBtnClick() {
        if self.paperBtn.isSelected {
            return
        }
//        self.poetryContainerView.updateTextColor(textColor: UIColor(hexColor: "A9A9AB"))
        self.poetryContainerView.isMirrorView = true
        self.paperBtn.isSelected = true
        self.albumBtn.isSelected = false
        self.hiddenSliderView(isHidden: true)
        self.hiddenBgImageCollectionView(isHidden: false)
        
//        self.poetryContainerView.bgImageView.setContentHuggingPriority(500, for: .vertical)
        
        self.showFirstBGImage()
    }
    
    internal func onAlbumBtnClick() {
        if self.albumBtn.isSelected {
            self.selectImage()
            return
        }
//        self.poetryContainerView.updateTextColor(textColor: UIColor.white)
        self.poetryContainerView.isMirrorView = false
        self.paperBtn.isSelected = false
        self.albumBtn.isSelected = true
        self.hiddenSliderView(isHidden: false)
        self.hiddenBgImageCollectionView(isHidden: true)
        self.updateImageWithSlider()
        
//        self.poetryContainerView.bgImageView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
    }
    
    
}




