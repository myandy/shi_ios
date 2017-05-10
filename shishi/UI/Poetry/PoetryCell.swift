//
//  AuthorCell.swift
//  shishi
//
//  Created by andymao on 2017/5/8.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit

class PoetryCell : UICollectionViewCell{
    
    lazy var poetryView: PoetryView = {
        let poetryView = PoetryView.loadNib()
        self.addSubview(poetryView)
        poetryView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        return poetryView
    }()
    
    public override init(frame: CGRect) {
     
        super.init(frame: frame)
         NSLog("PoetryCell init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh(poetry:Poetry,color:UIColor){
        poetryView.refresh(poetry: poetry,color:color)
        NSLog("PoetryCell")
    }
 
}
