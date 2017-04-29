//
//  BaseSearchTableViewCell.swift
//  shishi
//
//  Created by andymao on 2017/4/17.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

//
//  ChooseCollectionViewCell.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

public class BaseSearchCell: UITableViewCell {
    public var title:UILabel!
    public var desc:UILabel!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title = UILabel()
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(self)
        }
        desc = UILabel()
        desc.font=UIFont(name: FontsUtils.FONTS[0], size: 14)
        desc.textColor = UIColor(intColor:0x666666)
        addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(self)
        }
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
