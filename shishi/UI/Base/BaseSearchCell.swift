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
    public var title: UILabel!
    public var desc: UILabel!
    public var hint: UILabel!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let leftView = UIView()
        addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
//            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        title = UILabel()
        leftView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        desc = UILabel()
        desc.font=UIFont(name: FontsUtils.FONTS[0], size: 14)
        desc.textColor = SSTheme.Color.textHint
        leftView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
        
        hint = UILabel()
        hint.font=UIFont(name: FontsUtils.FONTS[0], size: 14)
        hint.textColor = SSTheme.Color.textHint
        hint.textAlignment = NSTextAlignment.right
        addSubview(hint)
        hint.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalTo(leftView.snp.right).offset(20)
        }

        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
