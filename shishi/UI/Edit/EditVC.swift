//
//  EditViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class EditVC: UIViewController {
    
    
    var writing : Writing!
    
    var editPagerView : EditPagerView?
    
    var backgroundPagerView : BackgroundPagerView?
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBAction func cancelBtnClick(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmBtnClick(_ sender: Any) {
    }
    init(former : Former) {
        writing=Writing()
        writing.former=former
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editPagerView = EditPagerView.loadNib()
        editPagerView?.writing=writing
        self.view.addSubview(editPagerView!)
        
        segmentedControl.tintColor=UIColor.clear
        segmentedControl.selectedSegmentIndex=0
        setSegmentedControlImage()
        
        editPagerView?.snp.makeConstraints { (make) in
                        make.top.equalTo( self.view)
                        make.bottom.equalTo(cancelBtn.snp.top)
                        make.left.equalTo(self.view)
            make.right.equalTo(self.view)
                    }

    }

    @IBAction func pagedChanged(_ sender: Any) {
        setSegmentedControlImage()
    }
    
    func setSegmentedControlImage(){
        let image1=segmentedControl.selectedSegmentIndex==0 ? "layout_bg_edit_selected":"layout_bg_edit"
        let image2=segmentedControl.selectedSegmentIndex==1 ? "layout_bg_paper_selected":"layout_bg_paper"
        let image3=segmentedControl.selectedSegmentIndex==2 ? "layout_bg_album_selected":"layout_bg_album"
        segmentedControl.setImage(UIImage(named: image1)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 0)
        segmentedControl.setImage(UIImage(named: image2)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 1)
        segmentedControl.setImage(UIImage(named: image3)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 2)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
