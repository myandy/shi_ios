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
    
    var poetryView: PoetryView!
    
    @IBAction func randomClick(_ sender: AnyObject) {
        refresh()
    }
    
    
    @IBAction func cancelClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var poetry:Poetry!
    
    lazy var colors = {
        return ColorDB.getAll()
    }()
   
    override public func viewDidLoad() {
        poetryView = PoetryView.loadNib()
        self.view.addSubview(poetryView)
        poetryView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.bottom.equalTo(cancelBtn.snp.top)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        refresh()
        
    }
    
    func refresh(){
        poetry = PoetryDB.getRandomPoetry()
        let random = Int(arc4random_uniform(UInt32(colors.count)))
        poetryView.refresh(poetry: poetry,color:(colors[random]).toUIColor())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
