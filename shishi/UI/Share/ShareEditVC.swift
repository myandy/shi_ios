//
//  ShareEditVC.swift
//  shishi
//
//  Created by andymao on 2017/6/4.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift

private let cellIdentifier = "cellIdentifier"

class ShareEditVC : UIViewController {
    var poetry:Poetry!
    
    //背景图片
    internal var bgImageArray = PoetryImage.allValues
    
    internal lazy var poetryContainerView: SharePoetryView = {
       let poetryContainerView = SharePoetryView(frame: CGRect.zero)
        return poetryContainerView
    }()
    
    internal lazy var poetryScrollView: UIScrollView = {
        let poetryScrollView = UIScrollView()
        return poetryScrollView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        
        return layout
        }()
    
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: self.collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    internal lazy var bottomBar: UIView = {
       let bottomBar = UIView()
        return bottomBar
    }()
    
    internal lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launch_image"))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.poetryContainerView.setupData(title: self.poetry.title, author: self.poetry.author, content: self.poetry.poetry)
        
        self.poetryContainerView.setupBGImage(image: self.bgImageArray[0].image())
    }
    
    internal func setupUI() {
        
        self.setupViews()
        self.setupConstraints()
        
        self.setupPoetryView()
    }
    
    internal func setupViews() {
        
        self.view.addSubview(self.bgImageView)
        
        self.collectionView.register(ShareImageCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(self.poetryScrollView)
        
        
        self.view.addSubview(self.collectionView)
        
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
        
        let confirmBtn = UIButton()
        self.bottomBar.addSubview(confirmBtn)
        confirmBtn.setImage(UIImage(named:"done"), for: .normal)
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(convertWidth(pix: -20))
            make.bottom.height.width.equalTo(cancleBtn)
        }
        confirmBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onConfirmBtnClick()
            })
            .addDisposableTo(self.rx_disposeBag)

    }
    
    internal func setupPoetryView() {
        self.poetryScrollView.addSubview(self.poetryContainerView)
        
        self.poetryContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
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
        
        
        
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.poetryScrollView.snp.bottom).offset(convertWidth(pix: 40))
            make.height.equalTo(convertWidth(pix: 250))
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
        let bgImage = self.poetryContainerView.bgImageView.image!
        let shareImage = SSImageUtil.genShiImage(bgImage, self.poetry.title, content: self.poetry.poetry)
        SSShareUtil.default.shareToSystem(controller: self, image: shareImage)
    }
}

extension ShareEditVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bgImageArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShareImageCollectionViewCell
        
        let image = self.bgImageArray[indexPath.row]
        cell.imageView.image = image.image()
        
        return cell
    }
}

extension ShareEditVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.bgImageArray[indexPath.row]
        self.poetryContainerView.setupBGImage(image: image.image())
    }
}

extension ShareEditVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.size.height, height: self.collectionView.bounds.size.height)
    }
}
