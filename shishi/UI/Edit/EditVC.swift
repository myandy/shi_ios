//
//  EditVC.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class EditVC: UIViewController {
    
    var writing : Writting!
    
    var editPagerView : EditPagerView!
    
    var backgroundPagerView : BackgroundPagerView?
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    fileprivate var bgImage = PoetryImage.bg001.image()
    
    @IBAction func cancelBtnClick(_ sender: Any) {
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
            SSControllerHelper.showShareContoller(controller: self, poetryTitle: self.writing.title, poetryAuthor: self.writing.author ?? "", poetryContent: self.writing.text, bgImage: self.bgImage)
        }
    }
    
    
    
    init(former : Former) {
        writing = Writting()
        writing.formerId = former.id
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
        
        editPagerView = EditPagerView()
        editPagerView.writing = writing
        self.view.addSubview(editPagerView)
        
        segmentedControl.tintColor = UIColor.clear
        segmentedControl.selectedSegmentIndex = 0
        setSegmentedControlImage()
        
        editPagerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(cancelBtn.snp.top)
        }
        
    }
    
    @IBAction func pagedChanged(_ sender: Any) {
        setSegmentedControlImage()
    }
    
    func setSegmentedControlImage(){
        let image1=segmentedControl.selectedSegmentIndex==0 ? "layout_bg_edit_selected":"layout_bg_edit"
        let image2=segmentedControl.selectedSegmentIndex==1 ? "layout_bg_paper_selected":"layout_bg_paper"
        segmentedControl.setImage(UIImage(named: image1)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 0)
        segmentedControl.setImage(UIImage(named: image2)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 1)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        self.writing.text = content
        self.writing.save(nil)
        SSNotificationCenter.default.post(name: SSNotificationCenter.Names.addWritting, object: nil)
        return true
    }
}
