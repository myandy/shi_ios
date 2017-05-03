//
//  AllCollectionViewCell.swift
//  shishi
//
//  Created by andymao on 2017/4/5.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

public class AllAuthorCell: UICollectionViewCell {

    public var top:UIView!
    public var lableDynasty:UILabel!
    public var lableDynastyEn:UILabel!
    public var lableNum:UILabel!
    public var lableAuthor:UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        top = UIView(frame:CGRect(x: 0, y: 0, width: 70, height: 3))
        self.addSubview(top)
        
        lableDynasty=UILabel(frame:CGRect(x:0,y:10,width:20,height:20))
        lableDynasty.layer.cornerRadius = 10
        lableDynasty.clipsToBounds = true
        lableDynasty.layer.borderWidth = 1
        lableDynasty.textAlignment = NSTextAlignment.center
        lableDynasty.font=UIFont(name: FontsUtils.FONTS[0], size: 12)
        self.addSubview(lableDynasty)
        
        lableDynastyEn=UILabel(frame:CGRect(x:-66,y:115,width:150,height:20))
        lableDynastyEn.transform=CGAffineTransform.init(rotationAngle:CGFloat(Double.pi/2))
        self.addSubview(lableDynastyEn)
        
        lableNum=UILabel(frame:CGRect(x:32,y:15,width:30,height:12))
        lableNum.font=UIFont(name: FontsUtils.FONTS[0], size: 15)
        lableNum.textAlignment = NSTextAlignment.center
        self.addSubview(lableNum)
        
        lableAuthor=UILabel(frame:CGRect(x:35,y:30,width:30,height:120))
        lableAuthor.font=UIFont(name: FontsUtils.FONTS[0], size: 24)
        lableAuthor.numberOfLines = 0
        self.addSubview(lableAuthor)
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
