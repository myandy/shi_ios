//
//  ShareEditVC.swift
//  shishi
//
//  Created by andymao on 2017/6/4.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift
import Photos

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
    
    //滑动条父视图
    internal lazy var sliderContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    internal lazy var brightnessSlider = UISlider()
    
    internal lazy var blurSlider = UISlider()
    
    internal var albumImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.poetryContainerView.setupData(title: self.poetry.title, author: self.poetry.author, content: self.poetry.poetry)
        
        self.showFirstBGImage()
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({ [unowned self] (status) in
                if status == .authorized {
                    self.resoveFirstAlbumImage()
                }
            })
        }
        else {
            self.resoveFirstAlbumImage()
        }
    }
    
    //显示第一张背景图
    internal func showFirstBGImage() {
        self.poetryContainerView.setupBGImage(image: self.bgImageArray[0].image())
    }
    
   
    
    //获取相册第一张图片
    internal func resoveFirstAlbumImage() {
        let fetchOptions = PHFetchOptions()
        let smartAlbums:PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        smartAlbums.enumerateObjects({ [weak self] (asset, index, isStop) in
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            let size = CGSize(width: 720, height: 1280)
            isStop.pointee = true
            imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { image, info in
                if let image = image {
                    self?.albumImage = image
                    
                }
            }
        })
    }
    
    internal func setupUI() {
        
        self.setupViews()
        self.setupConstraints()
        
        self.setupPoetryView()
        
        self.hiddenSliderView(isHidden: true)
    }
    
    internal func setupViews() {
        
        self.view.addSubview(self.bgImageView)
        
        self.collectionView.register(ShareImageCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(self.poetryScrollView)
        
        self.view.addSubview(self.collectionView)
        
        self.setupBottomView()
        
        self.setupSliderView()
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
        
        self.bottomBar.addSubview(self.paperBtn)
        self.paperBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(cancleBtn)
            make.right.equalTo(self.bottomBar.snp.centerX)
        }
        self.paperBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onPaperBtnClick()
            })
            .addDisposableTo(self.rx_disposeBag)
        
        self.bottomBar.addSubview(self.albumBtn)
        self.albumBtn.snp.makeConstraints { (make) in
            make.bottom.width.height.equalTo(cancleBtn)
            make.left.equalTo(self.paperBtn.snp.right)
        }
        self.albumBtn.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.onAlbumBtnClick()
            })
            .addDisposableTo(self.rx_disposeBag)
    }
    
    internal func setupPoetryView() {
        self.poetryScrollView.addSubview(self.poetryContainerView)
        
        self.poetryContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.height.greaterThanOrEqualToSuperview()
        }
    }
    
    internal func setupSliderView() {
        self.view.addSubview(self.sliderContainerView)
        self.sliderContainerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -30))
            make.top.bottom.equalTo(self.collectionView)
        }
        
        
        self.sliderContainerView.addSubview(brightnessSlider)
        brightnessSlider.isContinuous = false
        brightnessSlider.value = 0.5
        brightnessSlider.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.top.equalToSuperview().offset(convertWidth(pix: 20))
        }
        brightnessSlider.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] _ in
            self.onBrightnessSliderChange(value: self.brightnessSlider.value)
        }).addDisposableTo(self.rx_disposeBag)
        
        
        self.sliderContainerView.addSubview(blurSlider)
        blurSlider.isContinuous = false
        blurSlider.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.top.equalTo(brightnessSlider.snp.bottom).offset(convertWidth(pix: 20))
        }
        blurSlider.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] _ in
            self.onBlurSliderChange(value: self.blurSlider.value)
        }).addDisposableTo(self.rx_disposeBag)

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
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -10))
            make.top.equalTo(self.poetryScrollView.snp.bottom).offset(convertWidth(pix: 40))
            make.height.equalTo(convertWidth(pix: 250))
        }
        
        self.bottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.collectionView.snp.bottom)
        }
    }
    
    //显示图片列表
    internal func hiddenBgImageCollectionView(isHidden: Bool) {
        self.collectionView.isHidden = isHidden
    }
    
    //显示图片属性调节视图
    internal func hiddenSliderView(isHidden: Bool) {
        self.sliderContainerView.isHidden = isHidden
    }
    
    internal func imageUpdate(image: UIImage, blur: Float, brightness: Float) -> UIImage {
        let blurImage = self.imageUpdateBlur(image: image, value: blur)
        return self.imageUpdateBrightness(image: blurImage, value: brightness)
    }
    
    internal func imageUpdateBlur(image: UIImage, value: Float) -> UIImage {
        let radius: CGFloat = CGFloat(40 * value)
        let iterations: UInt = UInt(10 * value)
        let blurImage = image.blurredImage(withRadius: radius, iterations: iterations, tintColor: nil)!
        //self.poetryContainerView.setupBGImage(image: blurImage)
        return blurImage
    }
    
    internal func imageUpdateBrightness(image: UIImage, value: Float) -> UIImage {
        let context = CIContext(options: nil)
        let superImage = CIImage(cgImage:image.cgImage!)
        let lighten = CIFilter(name:"CIColorControls")
        lighten?.setValue(superImage, forKey: kCIInputImageKey)
        // 修改亮度   -1---1   数越大越亮
        let brightnessValue = (2 * value - 1)/2
        lighten?.setValue(brightnessValue, forKey: "inputBrightness")
        let result:CIImage = lighten?.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage:CGImage = context.createCGImage(result, from: superImage.extent)!
        
        // 得到修改后的图片
        let myImage = UIImage(cgImage: cgImage)
        
        // 释放对象
        //            CGImageRelease(cgImage);
        
        return myImage
        //            self.poetryContainerView.setupBGImage(image: myImage)
    }
}

//action
extension ShareEditVC {
    internal func onConfirmBtnClick() {
//        let bgImage = self.poetryContainerView.bgImageView.image!
//        let shareImage = SSImageUtil.genShiImage(bgImage, self.poetry.title, content: self.poetry.poetry)
//        SSShareUtil.default.shareToSystem(controller: self, image: shareImage)
        
        let shareController = ShareVC()
        shareController.poetry = self.poetry
        shareController.bgImage = self.poetryContainerView.bgImageView.image
        self.navigationController?.pushViewController(shareController, animated: true)
    }
    
    internal func onPaperBtnClick() {
        self.paperBtn.isSelected = true
        self.albumBtn.isSelected = false
        self.hiddenSliderView(isHidden: true)
        self.hiddenBgImageCollectionView(isHidden: false)
        
//        self.poetryContainerView.bgImageView.setContentHuggingPriority(500, for: .vertical)
        
        self.showFirstBGImage()
    }
    
    internal func onAlbumBtnClick() {
        self.paperBtn.isSelected = false
        self.albumBtn.isSelected = true
        self.hiddenSliderView(isHidden: false)
        self.hiddenBgImageCollectionView(isHidden: true)
        self.updateImageWithSlider()
        
//        self.poetryContainerView.bgImageView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
    }
    
    internal func updateImageWithSlider() {
        if let image = self.albumImage {
            let resultImage = self.imageUpdate(image: image, blur: self.blurSlider.value, brightness: self.brightnessSlider.value)
            self.poetryContainerView.setupBGImage(image: resultImage)
        }
    }
    
    internal func onBrightnessSliderChange(value: Float) {
//        if let image = self.albumImage {
//            let resultImage = self.imageUpdate(image: image, blur: self.blurSlider.value, brightness: value)
//            self.poetryContainerView.setupBGImage(image: resultImage)
//        }
        self.updateImageWithSlider()
    }
    
    internal func onBlurSliderChange(value: Float) {
//        if let image = self.albumImage {
//            let resultImage = self.imageUpdate(image: image, blur: value, brightness: self.brightnessSlider.value)
//            self.poetryContainerView.setupBGImage(image: resultImage)
//        }
        self.updateImageWithSlider()
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
