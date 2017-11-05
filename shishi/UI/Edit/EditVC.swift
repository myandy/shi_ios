//
//  EditVC.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class EditVC: EditBGImageVC {
    
    var writing : Writting!
    
    var editPagerView : EditPagerView!
    
    var backgroundPagerView : BackgroundPagerView?
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    fileprivate var bgImage = PoetryImage.bg001.image()
    
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        if !self.editPagerView.hasEdit {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let alertController = UIAlertController(title: "是否保存", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let alertView1 = UIAlertAction(title: "保存", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            if self.saveWritting() {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        let alertView2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(alertView1)
        alertController.addAction(alertView2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func confirmBtnClick(_ sender: Any) {
        
        if self.saveWritting() {
            let isAlbumImage = segmentedControl.selectedSegmentIndex == 2
            let bgImage = isAlbumImage ? self.albumImage : self.bgImage
            SSControllerHelper.showShareContoller(controller: self, poetryTitle: self.writing.title, poetryAuthor: self.writing.author ?? "", poetryContent: self.writing.text, bgImage: bgImage, isAlbumImage: isAlbumImage)
            //删除当前页面
            let index = self.navigationController!.viewControllers.index(of: self)
            self.navigationController!.viewControllers.remove(at: index!)
        }
    }
    
    
    
    init(former : Former) {
        writing = Writting()
        writing.formerId = former.id
        writing.title = former.name
        super.init(nibName: nil, bundle: nil)
    }
    
    init(writting : Writting) {
        self.writing = writting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editPagerView = EditPagerView(writting: writing)
        self.view.addSubview(editPagerView)
        
        segmentedControl.tintColor = UIColor.clear
        segmentedControl.selectedSegmentIndex = 0
        setSegmentedControlImage()
        
        editPagerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(cancelBtn.snp.top)
        }
        
        self.hiddenPoetryView(isHidden: true)
        self.hiddenBgImageCollectionView(isHidden: true)
    }
    
    func setSegmentedControlImage(){
        let image0 = segmentedControl.selectedSegmentIndex == 0 ? "layout_bg_edit_selected":"layout_bg_edit"
        let image1 = segmentedControl.selectedSegmentIndex == 1 ? "layout_bg_paper_selected":"layout_bg_paper"
        let image2 = segmentedControl.selectedSegmentIndex == 2 ? "layout_bg_album_selected":"layout_bg_album"
      
        segmentedControl.setImage(UIImage(named: image0)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 0)
        segmentedControl.setImage(UIImage(named: image1)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 1)
        segmentedControl.setImage(UIImage(named: image2)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 2)
        
    }

    
    @IBAction func pagedChanged(_ sender: Any) {
        setSegmentedControlImage()
        
        self.editPagerView.isHidden = segmentedControl.selectedSegmentIndex != 0
        self.hiddenPoetryView(isHidden: segmentedControl.selectedSegmentIndex == 0)
        self.hiddenBgImageCollectionView(isHidden: segmentedControl.selectedSegmentIndex != 1)
        self.hiddenSliderView(isHidden: segmentedControl.selectedSegmentIndex != 2)
        
        if segmentedControl.selectedSegmentIndex != 0 {
            self.updatePoetryView()
        }
        if segmentedControl.selectedSegmentIndex == 1 {
            self.poetryContainerView.isMirrorView = true
            self.showFirstBGImage()
            self.poetryContainerView.updateTextColor(textColor: UIColor(hexColor: "A9A9AB"))
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            self.poetryContainerView.updateTextColor(textColor: UIColor.white)
            self.poetryContainerView.isMirrorView = false
            self.updateImageWithSlider()
        }
    }
    
    override func tapHandler() {
        if segmentedControl.selectedSegmentIndex == 2 {
            self.selectImage()
        }
        
    }
    
    //背景图片变化
    override func onBGImageUpdate(image: UIImage) {
        self.editPagerView.updateImage(image: image)
        self.editPagerView.hasEdit = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func saveAlbumBgImage(image: UIImage) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let imagesDirectoryPath = (documentDirectorPath as NSString).appendingPathComponent("writting")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)

            }catch{
                print("Something went wrong while creating a new folder")
                return nil
            }
        }
        let imageName = Date().description
        let imagePath = (imagesDirectoryPath as NSString).appendingPathComponent(imageName)
        let data = UIImagePNGRepresentation(image)
        let success = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        if success {
            return imageName
        }
        else {
            return nil
        }
    }
    
    fileprivate func saveWritting() -> Bool {
        if self.writing.title.isEmpty {
            self.showToast(message: "标题不能为空")
            return false
        }
        let content = self.editPagerView.mergeContent()
        if content.isEmpty {
            self.showToast(message: "内容不能为空")
            return false
        }
        if self.segmentedControl.selectedSegmentIndex == 1 {
            let bgImageId = self.poetryContainerView.bgImageId
            self.writing.bgImg = Int64(bgImageId!)
            self.writing.bgImgName = nil
        }
        else if self.segmentedControl.selectedSegmentIndex == 2 {
            self.writing.bgImg = 0
            let bgImage = self.poetryContainerView.bgImage
            self.writing.bgImgName = self.saveAlbumBgImage(image: bgImage!)
        }
        else {
            self.writing.bgImg = 0
            self.writing.bgImgName = nil
        }
        self.writing.text = content
        self.writing.save(nil)
        SSNotificationCenter.default.post(name: SSNotificationCenter.Names.addWritting, object: nil)
        return true
    }
    
    internal func hiddenPoetryView(isHidden: Bool) {
        self.poetryScrollView.isHidden = isHidden
    }
    
    internal func updatePoetryView() {
        let title = self.writing.getTitle()
        let author = ""
        let content = self.editPagerView.mergeContent()
        self.poetryContainerView.setupData(title: title, author: author, content: content)
    }
}
