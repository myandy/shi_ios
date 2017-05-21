//
//  SearchYunCell.swift
//  shishi
//
//  Created by andymao on 2017/5/20.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SearchYunCell : UITableViewCell {
    
    public var title: UILabel!
    
    public var content: UILabel!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        title = UILabel()
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        content = UILabel()
        content.font = UIFont(name: FontsUtils.FONTS[0], size: 14)
        content.textColor = SSTheme.Color.textHint
        content.numberOfLines = 0
        self.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }

        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
