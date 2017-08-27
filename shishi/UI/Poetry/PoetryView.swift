//
//  PoetryView.swift
//  shishi
//
//  Created by andymao on 2017/4/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class PoetryView : UIView, Nibloadable {
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var shareBtn: UIButton!
    
    var actionHandel: ((UIButton) -> Void)!
    
    @IBAction func shareClick(_ sender: AnyObject) {
        self.actionHandel(sender as! UIButton)
    }
    
    override func draw(_ rect: CGRect) {
//        self.backgroundColor=UIColor.clear
        FontsUtils.setFont(self)
        shareBtn.layer.cornerRadius = shareBtn.frame.size.width / 2
    }
    
    func refresh(poetry:Poetry,color:UIColor){
        titleLabel.text = poetry.title
        contentLabel.text = poetry.poetry
        
        if (poetry.intro?.characters.count)! > 5{
            introLabel.text=poetry.intro
        }
        else{
            introLabel.text = nil
        }
        
        shareBtn.backgroundColor = color
        authorLabel.text = poetry.author
        
    }
    public override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
    }
    
}
