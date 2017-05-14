//
//  PoetryCellVC.swift
//  shishi
//
//  Created by andymao on 2017/5/8.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit

class PoetryCellVC : UIViewController{
    
    lazy var poetryView: PoetryView = {
        let poetryView = PoetryView.loadNib()
        self.view.addSubview(poetryView)
        poetryView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        return poetryView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }

    
    func refresh(poetry:Poetry,color:UIColor){
      
        NSLog("PoetryCell")
    }
    
    init(poetry:Poetry,color:UIColor) {
        super.init(nibName: nil, bundle: nil)

        self.poetryView.refresh(poetry: poetry,color:color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
}
