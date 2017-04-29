//
//  RandomPoetryViewController.swift
//  shishi
//
//  Created by andymao on 2016/12/24.
//  Copyright © 2016年 andymao. All rights reserved.
//

import UIKit

class RandomPoetryVC: UIViewController {
    
    @IBOutlet weak var randomBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    var poetryView:PoetryView?
    
    @IBAction func randomClick(_ sender: AnyObject) {
        refresh()
    }
    
    
    @IBAction func cancelClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var poetry:Poetry!
    

    
    override public func viewDidLoad() {
        
        poetryView = PoetryView.loadNib()
        self.view.insertSubview(poetryView!, aboveSubview: backgroundView)

        poetryView?.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.bottom.equalTo(cancelBtn.snp.top)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
                refresh()
        
    }
    
    func refresh(){
        poetry = PoetryDB.getRandomPoetry()
        poetryView?.refresh(poetry: poetry)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
