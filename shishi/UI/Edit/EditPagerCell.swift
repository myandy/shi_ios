//
//  EditPagerCell.swift
//  shishi
//
//  Created by andymao on 2017/5/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class EditPagerCell : UITableViewCell {
    
    private var pingzeLinearView: PingzeLinearView!
    
    var code: String!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        pingzeLinearView = PingzeLinearView()
        addSubview(pingzeLinearView)
        pingzeLinearView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }

        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        addSubview(textField)
        textField.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview()
            make.top.equalTo(pingzeLinearView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        textField.delegate = self

        FontsUtils.setFont(textField)
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
    
    public func refresh(code:String){
        self.code = code
        pingzeLinearView.refresh(code: code)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EditPagerCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {

        EditUtils.checkTextFiled(textFiled: textField,code: self.code)
        NSLog("test","")
    }
}
