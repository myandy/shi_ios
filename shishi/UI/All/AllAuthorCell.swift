//
//  AllAuthorCell.swift
//  shishi
//
//  Created by andymao on 2017/4/5.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

public class AllAuthorCell: UICollectionViewCell {

    public var topView: UIView!
    public var dynastyLabel: UILabel!
    public var dynastyEnLabel: UILabel!
    public var numLabel: UILabel!
    public var authorLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        topView = UIView(frame:CGRect(x: 0, y: 0, width: 70, height: 3))
        self.addSubview(topView)
        
        dynastyLabel=UILabel(frame:CGRect(x:0,y:10,width:20,height:20))
        dynastyLabel.layer.cornerRadius = 10
        dynastyLabel.clipsToBounds = true
        dynastyLabel.layer.borderWidth = 1
        dynastyLabel.textAlignment = NSTextAlignment.center
        dynastyLabel.font=UIFont(name: FontsUtils.FONTS[0], size: 12)
        self.addSubview(dynastyLabel)
        
        dynastyEnLabel=UILabel(frame:CGRect(x:-66,y:115,width:150,height:20))
        dynastyEnLabel.transform=CGAffineTransform.init(rotationAngle:CGFloat(Double.pi/2))
        self.addSubview(dynastyEnLabel)
        
        numLabel=UILabel(frame:CGRect(x:32,y:15,width:30,height:12))
        numLabel.font=UIFont(name: FontsUtils.FONTS[0], size: 15)
        numLabel.textAlignment = NSTextAlignment.center
        self.addSubview(numLabel)
        
        authorLabel=UILabel(frame:CGRect(x:35,y:30,width:30,height:120))
        authorLabel.font= UIFont(name: FontsUtils.FONTS[0], size: 24)
        authorLabel.numberOfLines = 0
        self.addSubview(authorLabel)
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
