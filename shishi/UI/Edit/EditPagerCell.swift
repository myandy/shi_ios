//
//  EditPagerCell.swift
//  shishi
//
//  Created by andymao on 2017/5/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class EditPagerCell : UITableViewCell {
    
    public var pingzeLinearView: PingzeLinearView!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pingzeLinearView = PingzeLinearView()
        addSubview(pingzeLinearView)
        pingzeLinearView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.top.equalToSuperview()
            make.height.equalTo(30)
        }

        let textField = UITextField()
        textField.textColor = UIColor.lightGray
        textField.tintColor = UIColor.lightGray
        addSubview(textField)
        textField.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.top.equalToSuperview()
            make.height.equalTo(20)
        }

        
//        let lineView = UIView()
//        lineView.backgroundColor = UIColor.lightGray
//        addSubview(lineView)
//        lineView.snp.makeConstraints{ (make) in
//            make.left.equalToSuperview().offset(10)
//            make.right.equalToSuperview()
//            make.top.equalToSuperview().offset(<#T##amount: ConstraintOffsetTarget##ConstraintOffsetTarget#>)
//            make.height.equalTo(1)
//        }

        

        
        
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
