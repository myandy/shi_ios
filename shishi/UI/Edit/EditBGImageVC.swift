//
//  EditBGImageVC.swift
//  shishi
//
//  Created by tb on 2017/10/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import Photos
import FXBlurView

private let cellIdentifier = "cellIdentifier"

class EditBGImageVC: UIViewController {
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
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        
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
    
    //滑动条父视图
    internal lazy var sliderContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    internal lazy var brightnessSlider = UISlider()
    
    internal lazy var blurSlider = UISlider()
    
    internal var albumImage: UIImage?
    
    //背景图片
    internal var bgImageArray = PoetryImage.allValues
    
    internal var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
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
        
        let guesture = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        self.poetryContainerView.addGestureRecognizer(guesture)
        
    }
    
    internal func setupUI() {
        self.setupViews()
        self.setupConstraints()
        
        self.setupPoetryView()
        
        self.hiddenSliderView(isHidden: true)
        
        FontsUtils.setFont(self.poetryScrollView)
    }
    
    internal func setupViews() {
        self.view.addSubview(self.poetryScrollView)
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.register(ShareImageCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.setupSliderView()
    }
    
    internal func setupPoetryView() {
        self.poetryScrollView.addSubview(self.poetryContainerView)
        
        self.poetryContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()//.offset(convertWidth(pix: -20))
            make.height.greaterThanOrEqualToSuperview()
        }
    }

    internal func setupConstraints() {
        
        self.poetryScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(convertWidth(pix: 100))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(self.poetryScrollView.snp.width)
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -10))
            make.top.equalTo(self.poetryScrollView.snp.bottom).offset(convertWidth(pix: 40))
            make.height.equalTo(convertWidth(pix: 250))
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
        brightnessSlider.isContinuous = true
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
        blurSlider.isContinuous = true
        blurSlider.value = 0.3
        blurSlider.maximumValue = 0.6
        blurSlider.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(convertWidth(pix: -20))
            make.top.equalTo(brightnessSlider.snp.bottom).offset(convertWidth(pix: 20))
        }
        blurSlider.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] _ in
            self.onBlurSliderChange(value: self.blurSlider.value)
        }).addDisposableTo(self.rx_disposeBag)
        
    }
    
    func tapHandler() {
        
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
                    self?.albumImage = self?.resizedImage(image: image)
                    
                }
            }
        })
    }
    
    //相册选择图片
    func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    //背景图片变化,子类处理
    internal func onBGImageUpdate(image: UIImage) {
        
    }
    
    //显示第一张背景图
    internal func showFirstBGImage() {
        self.poetryContainerView.setupBGImage(image: self.bgImageArray[0].image(), imageId: self.bgImageArray[0].rawValue)
    }
    
    internal func updateImageWithSlider() {
        if let image = self.albumImage {
            let resultImage = self.imageUpdate(image: image, blur: self.blurSlider.value, brightness: self.brightnessSlider.value)
            self.poetryContainerView.setupBGImage(image: resultImage, imageId: nil)
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
        //        // 修改亮度   -255---255   数越大越亮
        let brightnessValue = (2 * value - 1)/2 * 255 * 0.6
        let brigntImage = image.cgImage!.brightened(value: brightnessValue)
        return UIImage(cgImage: brigntImage!)
        
        
        //        let context = CIContext(options: nil)
        //        let superImage = CIImage(cgImage:image.cgImage!)
        //        let lighten = CIFilter(name:"CIColorControls")
        //        lighten?.setValue(superImage, forKey: kCIInputImageKey)
        //        // 修改亮度   -1---1   数越大越亮
        //        let brightnessValue = (2 * value - 1)/2
        //        lighten?.setValue(brightnessValue, forKey: "inputBrightness")
        //        let result:CIImage = lighten?.value(forKey: kCIOutputImageKey) as! CIImage
        //        let cgImage:CGImage = context.createCGImage(result, from: superImage.extent)!
        //
        //        // 得到修改后的图片
        //        let myImage = UIImage(cgImage: cgImage)
        //        
        //        return myImage
    }
}

extension EditBGImageVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bgImageArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShareImageCollectionViewCell
        
        let image = self.bgImageArray[indexPath.row]
        cell.imageView.image = image.image()
        cell.updateSelectedStatus(isSelected: self.selectedImageIndex == indexPath.row)
        
        return cell
    }
}

extension EditBGImageVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.bgImageArray[indexPath.row]
        self.poetryContainerView.setupBGImage(image: image.image(), imageId: image.rawValue)
        self.onBGImageUpdate(image: image.image())
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ShareImageCollectionViewCell {
            cell.updateSelectedStatus(isSelected: true)
        }
        
        if let cell = collectionView.cellForItem(at: IndexPath(row: self.selectedImageIndex, section: indexPath.section)) as? ShareImageCollectionViewCell {
            cell.updateSelectedStatus(isSelected: false)
        }
        
        self.selectedImageIndex = indexPath.row
    }
    
    //    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    //    }
}

extension EditBGImageVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.size.height, height: self.collectionView.bounds.size.height)
    }
}

extension EditBGImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // use the image
        //self.albumImage = chosenImage.fixOrientation()
        let image = chosenImage.fixOrientation()!
        self.albumImage = self.resizedImage(image: image)
        self.poetryContainerView.setupBGImage(image: self.albumImage!, imageId: nil)
        self.onBGImageUpdate(image: self.albumImage!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func resizedImage(image: UIImage) -> UIImage {
       
        let maxWidth: CGFloat = 720
        if image.size.width <= maxWidth {
            return image
        }
        
        
        let resizeSize = CGSize(width: maxWidth, height: image.size.height / image.size.width * maxWidth)
        
        return image.imageScaledToSize(newSize: resizeSize)
    }
}

internal extension UIImage {
    func imageScaledToSize(newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        self.draw(in: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
