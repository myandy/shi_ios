//
//  PoetryView.swift
//  shishi
//
//  Created by andymao on 2017/4/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class PoetryView : UIView,Nibloadable{
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBAction func shareClick(_ sender: AnyObject) {
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor=UIColor.clear
        FontsUtils.setFont(self)
        shareBtn.layer.cornerRadius = shareBtn.frame.size.width / 2
    }
    
    func refresh(poetry:Poetry,color:UIColor){
        titleLable.text=poetry.title
        contentLable.text=poetry.poetry
        
        if (poetry.intro?.characters.count)! > 5{
            introLabel.text=poetry.intro
        }
        else{
            introLabel.text=nil
        }
        
        shareBtn.backgroundColor = color
        authorLable.text=poetry.author
        
    }
    public override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
    }
    
}
