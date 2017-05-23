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
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBAction func shareClick(_ sender: AnyObject) {
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        FontsUtils.setFont(view: self)
        shareBtn.layer.cornerRadius = shareBtn.frame.size.width / 2
    }
    
    func refresh(poetry: Poetry){
        titleLabel.text = poetry.title
        contentLabel.text = poetry.poetry
        
        if (poetry.intro?.characters.count)! > 5{
            introLabel.text = poetry.intro
        }
        else{
            introLabel.text = nil
        }
        
        let data = AuthorDB.getAuthor(name: poetry.author!)
        
        let cInt : Int32  = data!.color as Int32!
        let color = UIColor(intColor:Int(cInt))
        shareBtn.backgroundColor = color
        authorLabel.text = poetry.author
        
    }
    public override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
    }
    
}
