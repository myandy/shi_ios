//
//  EditPagerCell.swift
//  shishi
//
//  Created by andymao on 2017/5/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit

class EditPagerCell : UITableViewCell {
    
    private var pingzeLinearView: PingzeLinearView!
    
    private var textField: UITextField!
    
    var code: String!
    
    public var editHandler: ((String?) -> Void)!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        pingzeLinearView = PingzeLinearView()
        addSubview(pingzeLinearView)
        pingzeLinearView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        
        self.textField = UITextField()
//        textField.textColor = UIColor.black
//        textField.tintColor = UIColor.black
        addSubview(textField)
        textField.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview()
            make.top.equalTo(pingzeLinearView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        textField.delegate = self
        
        //        let lineView = UIView()
        //        lineView.backgroundColor = UIColor.lightGray
        //        addSubview(lineView)
        //        lineView.snp.makeConstraints{ (make) in
        //            make.left.equalToSuperview().offset(10)
        //            make.right.equalToSuperview()
        //            make.top.equalToSuperview().offset(<#T##amount: ConstraintOffsetTarget##ConstraintOffsetTarget#>)
        //            make.height.equalTo(1)
        //        }
        
//        textField.rx.text.subscribe(onNext:{ [unowned self] (text) in
//            guard let text = text, !text.isEmpty else {
//                return
//            }
//            EditUtils.checkTextField(textField: self.textField,code: self.code)
//        }).addDisposableTo(self.rx_disposeBag)
        
        if UserDefaultUtils.isCheckPingze() {
            textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
        
        
    }
    
    fileprivate func checkTextField(textField: UITextField, code: String) {
        guard let text = textField.attributedText?.string, !text.isEmpty else {
            return
        }
        
        let attrString = EditUtils.pingzeString(text: text, code: code)
        textField.attributedText = attrString
    }
    
    @objc fileprivate func textFieldDidChange(textField: UITextField) {
        
        
        //点击完选中的字之后
        if textField.markedTextRange == nil {
            self.checkTextField(textField: textField, code: self.code)
        }
    }
    
    public func refresh(code:String, content: String?){
        self.code = code
        pingzeLinearView.refresh(code: code)
        
        self.textField.text = content
        if UserDefaultUtils.isCheckPingze() {
            
            self.checkTextField(textField: self.textField, code: self.code)
        }
       
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EditPagerCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {

        if UserDefaultUtils.isCheckPingze() {
            self.checkTextField(textField: textField, code: self.code)
        }

        self.editHandler(textField.attributedText?.string)
    }

//    public func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let text = textField.attributedText?.string {
//            textField.attributedText = nil
//            textField.text = text
//        }
//    }
}

