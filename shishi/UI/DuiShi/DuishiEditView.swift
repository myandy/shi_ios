//
//  DuishiEditView.swift
//  shishi
//
//  Created by tb on 2017/5/6.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

private let itemWidth: CGFloat = 34
private let itemSpace: CGFloat = 10

//没有输入时的默认文本
private let emptyText = DuishiAPI.emptyLoker

class DuishiEditView: UIView {
    var lockerTFStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeAllTF()
    }
    
    func setupUI() {
        let scrollView = UIScrollView()
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.lockerTFStackView = UIStackView()
        scrollView.addSubview(self.lockerTFStackView)
        self.lockerTFStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(0)
        }
        
        self.lockerTFStackView.axis = .horizontal
        self.lockerTFStackView.alignment = .fill
        self.lockerTFStackView.spacing = itemSpace
        self.lockerTFStackView.distribution = .fillEqually
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalMargin = (self.bounds.size.height - itemWidth) / 2
        self.lockerTFStackView.layoutMargins = UIEdgeInsets(top: verticalMargin, left: itemSpace, bottom: verticalMargin, right: itemSpace)
        self.lockerTFStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    //重置输入框
    func reset(itemCount: Int) {
        self.removeAllTF()
        self.addTF(itemCount: itemCount)
    }
    
    //获取当前输入框内容
    func currentText() -> String? {
        let textFieldArray = self.lockerTFStackView.arrangedSubviews
        var resultString = ""
        for textField in textFieldArray {
            
            var inputText = (textField as! UITextField).text
            if inputText == nil || inputText!.isEmpty {
                inputText = emptyText
            }
            
            resultString += inputText!
        }
        return resultString.isEmpty ? nil : resultString
    }
    
    fileprivate func removeAllTF() {
        for subView in self.lockerTFStackView.arrangedSubviews {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: subView)
            self.lockerTFStackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
    
    fileprivate func addTF(itemCount: Int) {
        for _ in 0..<itemCount {
            let tf = UITextField()
            tf.backgroundColor = UIColor.white
            tf.layer.cornerRadius = 5
            tf.layer.masksToBounds = true
            tf.textAlignment = .center
//            tf.delegate = self
            NotificationCenter.default.addObserver(self, selector: #selector(self.onTextFieldEditChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: tf)
            self.lockerTFStackView.addArrangedSubview(tf)
            
//            tf.snp.makeConstraints({ (make) in
//                make.width.height.equalTo(34)
//            })
        }
        
        self.lockerTFStackView.snp.updateConstraints { (make) in
            make.width.equalTo(CGFloat(itemCount) * (itemWidth + itemSpace) + itemSpace)
        }
    }
    
    //切换下一个文本框输入
    fileprivate func responsToNextTextField(from textField: UITextField) {
        guard let nextTextField = self.nextTextField(from: textField) else {
            return
        }
        
        nextTextField.becomeFirstResponder()
    }
    
    //切换是一个文本框输入
    fileprivate func responsToPreviousTextField(from textField: UITextField) {
        guard let previousTextField = self.previousTextField(from: textField) else {
            return
        }
        
        //事件未传递完成，延时处理
        delayToMainThread(delay: 0.001) { 
            previousTextField.becomeFirstResponder()
        }
        
    }
    
    //下一个文本框
    fileprivate func nextTextField(from textField: UITextField) -> UITextField? {
        let textFieldArray = self.lockerTFStackView.arrangedSubviews
        let index = textFieldArray.index { (element) -> Bool in
            return element === textField
        }
        
        assert(index != nil)
        if index! == textFieldArray.count - 1 {
            return nil
        }
        return textFieldArray[index! + 1] as? UITextField
    }
    
    //上一个文本框
    fileprivate func previousTextField(from textField: UITextField) -> UITextField? {
        let textFieldArray = self.lockerTFStackView.arrangedSubviews
        let index = textFieldArray.index { (element) -> Bool in
            return element === textField
        }
        
        assert(index != nil)
        if index! == 0 {
            return nil
        }
        return textFieldArray[index! - 1] as? UITextField
    }
    
    class func checkChinese(_ text: String) ->Bool {
        let pattern = "^[\\u4E00-\\u9FA5]"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: text)
        return isMatch
    }
}


// MARK: - NSNotification
extension DuishiEditView {
    @objc fileprivate func onTextFieldEditChanged(_ notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        let lang = self.textInputMode?.primaryLanguage// 键盘输入模式
        if lang == "zh-Hans" {// 简体中文输入，包括简体拼音，健体五笔，简体手写
            //获取高亮部分
            guard let _ = textField.markedTextRange else {
                //汉字输入完成
                if let text = textField.text, text.characters.count > 0 {
//                    let index = text.index(text.startIndex, offsetBy: 1)
//                    textField.text = text.substring(to: index)
                    self.responsToNextTextField(from: textField)
                    
                }
                return
            }
//            let position = textField.position(from: selectedRange.start, offset: 0)
//            // 没有高亮选择的字
//            if position == nil {
//                
//            }       // 有高亮选择的字符串，则暂不处理
//            else{
//            }

        }
        
        
        if let text = textField.text {
            //检测中文
            if !type(of: self).checkChinese(text) {
                textField.text = ""
            }
            //长度
            if text.characters.count > 1 {
                let index = text.index(text.endIndex, offsetBy: -1)
                textField.text = text.substring(from: index)
            }
        }
        
    }
}


// MARK: - UITextFieldDelegate
//使用代理shouldChangeCharactersInRange判断的是当前键盘的字符数, "张"的拼音是Zhang, 于是你在输入Z的时候就无法输入了. 显然, 这样的结果不是我们想要的.
//所以不要在这里做输入控制，用通知实现
//extension DuishiEditView : UITextFieldDelegate {
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let textFieldString = (textField.text ?? "") as NSString
//        let resultString = textFieldString.replacingCharacters(in: range, with: string)
//        let isPressedBackspaceAfterSingleSpaceSymbol = string == "" && resultString == "" && range.location == 0 && range.length == 1
//        if isPressedBackspaceAfterSingleSpaceSymbol {
//            self.responsToPreviousTextField(from: textField)
//        }
//        
//        return true
//
//        if string.characters.count > 1 {
//            return false
//        }
//        
//        //有可能是删除操作 string.characters.count == 0
//        if (textField.text?.characters.count)! >= 1 && string.characters.count > 0 {
//            return false
//        }
//        else {
//            self.responsToNextTextField(from: textField)
//            return true
//        }
//    }
//}


