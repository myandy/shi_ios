//
//  SSImageUtil.swift
//  shishi
//
//  Created by tb on 2017/6/14.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSImageUtil: NSObject {
    public static func genShiImage(_ bgImage: UIImage?, _ title: String, content: String) -> UIImage {
        let bgView = UIView(frame: UIScreen.main.bounds)
        let drawView = UIImageView()
        bgView.addSubview(drawView)
        drawView.image = bgImage
//        drawView.setContentHuggingPriority(1000, for: .vertical)
        drawView.setContentCompressionResistancePriority(250, for: .vertical)
        
        let maxWidth = bgImage?.size.width ?? UIScreen.main.bounds.size.width
        drawView.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(maxWidth)
        }
        
        let titleLabel = UILabel()
        drawView.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(convertWidth(pix: 20))
            make.centerX.equalToSuperview()
        }
        
        let contentLabel = UILabel()
        drawView.addSubview(contentLabel)
        contentLabel.text = content
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(convertWidth(pix: 20))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(convertWidth(pix: -20))
        }
        
        
        bgView.layoutIfNeeded()
        
        let image = SSImageUtil.image(with: drawView)
        
        return image
    }
    
//    public static func genShiImage(_ bgImage: UIImage?, _ title: String, content: String) -> UIImage {
//        let titleAttrString = NSAttributedString(string: title,
//                                                 attributes: [
//                                                    NSFontAttributeName : UIFont.boldSystemFont(ofSize: 20.0),
//                                                    NSForegroundColorAttributeName : UIColor.black,
//                                                    ])
//        
//        let maxWidth = bgImage?.size.width ?? UIScreen.main.bounds.size.width
//        let horizonalPadding = convertWidth(pix: 20)
//        let maxSize = CGSize(width: maxWidth - horizonalPadding * 2, height: CGFloat(MAXFLOAT))
//        let titleSize = titleAttrString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
//        
//        let drawView = UIImageView()
//        drawView.image = bgImage
//        drawView.frame = CGRect(origin: CGPoint.zero, size: titleSize.size)
//        
//        let image = SSImageUtil.image(with: drawView)
//        return image
//    }
    
    public static func image(with view: UIView) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.layer.frame.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return viewImage
    }
}
