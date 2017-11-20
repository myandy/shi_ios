//
//  SSAppLanguage.swift
//  shishi
//
//  Created by tb on 2017/11/19.
//  Copyright © 2017年 andymao. All rights reserved.
//


//APP使用的语言
enum SSAppLanguage: Int {
    case simplifiedChinese = 0,
    traditionalChinese = 1,
    `default` = 2
    
    static let all: [SSAppLanguage] = [.simplifiedChinese, .traditionalChinese, .default]
}

extension SSAppLanguage {
    
    public func toString() -> String {

        switch self {
        case .simplifiedChinese:
            return SSStr.Setting.FONT_SIMPLIFIEDCHINESE
        case .traditionalChinese:
            return SSStr.Setting.FONT_TRADITIONALCHINESE
        case .default:
            return SSStr.Setting.FONT_DEFAULT
        }
    }
    
    public static func isSimplifiedChinese() -> Bool {
        return currentLanguage() == SSAppLanguage.simplifiedChinese
    }
    
    public static func currentLanguage() -> SSAppLanguage {
        let language = UserDefaultUtils.getFont()
        return SSAppLanguage(rawValue: language)!
    }
    
    //转换语言
    public static func fixViewLanguage(view: UIView) {
        if let label = view as? UILabel{
            label.text = label.text?.fixLanguage()
        }
        else if let textField = view as? UITextField {
            textField.text = textField.text?.fixLanguage()
        }
        else if let textView = view as? UITextView {
            textView.text = textView.text.fixLanguage()
        }
        else if let button = view as? UIButton {
            button.setTitle(button.title(for: .normal)?.fixLanguage(), for: .normal)
            button.setTitle(button.title(for: .highlighted)?.fixLanguage(), for: .highlighted)
            button.setTitle(button.title(for: .selected)?.fixLanguage(), for: .selected)
            button.setTitle(button.title(for: .disabled)?.fixLanguage(), for: .disabled)
        }
        
        for subview in view.subviews{
            fixViewLanguage(view: subview)
        }
        
    }
}

//语言转换
extension String {
    //转换语言
    public func fixLanguage() -> String {
        let language = SSAppLanguage.currentLanguage()
        switch language {
        case .simplifiedChinese:
            return self.toSimple()
        case .traditionalChinese:
            return self.toTradition()
        case .default:
            return self.autoChange()
        }
    }
}

extension UIViewController {
    //转换语言
    public func fixLanguage() {
        if let navi = self as? UINavigationController {
            navi.viewControllers.forEach({ (controller) in
                controller.fixLanguage()
            })
        }
        else {
            SSAppLanguage.fixViewLanguage(view: self.view)
        }
        
    }
    
    
}
