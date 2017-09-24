//
//  SSImageUtil.swift
//  shishi
//
//  Created by tb on 2017/6/14.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import Accelerate

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
        
        let widthOffset = convertWidth(pix: 20)
        
        let titleLabel = UILabel()
        drawView.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(convertWidth(pix: 20))
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().offset(-widthOffset)
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
            make.width.lessThanOrEqualToSuperview().offset(-widthOffset)
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


public let numberOfComponentsPerARBGPixel = 4
public let numberOfComponentsPerRGBAPixel = 4
public let numberOfComponentsPerGrayPixel = 3
public extension CGContext
{
    // MARK: - ARGB bitmap context
    public class func ARGBBitmapContext(width: Int, height: Int, withAlpha: Bool) -> CGContext?
    {
        let alphaInfo = withAlpha ? CGImageAlphaInfo.premultipliedFirst : CGImageAlphaInfo.noneSkipFirst
        let bmContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * numberOfComponentsPerARBGPixel, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: alphaInfo.rawValue)
        return bmContext
    }
    
    // MARK: - RGBA bitmap context
    public class func RGBABitmapContext(width: Int, height: Int, withAlpha: Bool) -> CGContext?
    {
        let alphaInfo = withAlpha ? CGImageAlphaInfo.premultipliedLast : CGImageAlphaInfo.noneSkipLast
        let bmContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * numberOfComponentsPerRGBAPixel, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: alphaInfo.rawValue)
        return bmContext
    }
    
    // MARK: - Gray bitmap context
    public class func GrayBitmapContext(width: Int, height: Int) -> CGContext?
    {
        let bmContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * numberOfComponentsPerGrayPixel, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue)
        return bmContext
    }
}

private let minPixelComponentValue = UInt8(0)
private let maxPixelComponentValue = UInt8(255)

// MARK: -
public extension CGImage
{
    public func hasAlpha() -> Bool
    {
        let alphaInfo = self.alphaInfo
        return (alphaInfo == .first || alphaInfo == .last || alphaInfo == .premultipliedFirst || alphaInfo == .premultipliedLast)
    }
}

extension CGImage {
    // Value should be in the range (-255, 255)
    public func brightened(value: Float) -> CGImage?
    {
        // Create an ARGB bitmap context
        let width = self.width
        let height = self.height
        guard let bmContext = CGContext.ARGBBitmapContext(width: width, height: height, withAlpha: self.hasAlpha()) else
        {
            return nil
        }
        
        // Get image data
        bmContext.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let data = bmContext.data else
        {
            return nil
        }
        
        let pixelsCount = UInt(width * height)
        let pixelsCountInt = Int(pixelsCount)
        let dataAsFloat = UnsafeMutablePointer<Float>.allocate(capacity: pixelsCountInt)
        var min = Float(minPixelComponentValue), max = Float(maxPixelComponentValue)
        
        // Calculate red components
        var v = value
        let t: UnsafeMutablePointer<UInt8> = data.assumingMemoryBound(to: UInt8.self)
        vDSP_vfltu8(t + 1, 4, dataAsFloat, 1, pixelsCount)
        vDSP_vsadd(dataAsFloat, 1, &v, dataAsFloat, 1, pixelsCount)
        vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount)
        vDSP_vfixu8(dataAsFloat, 1, t + 1, 4, pixelsCount)
        
        // Calculate green components
        vDSP_vfltu8(t + 2, 4, dataAsFloat, 1, pixelsCount)
        vDSP_vsadd(dataAsFloat, 1, &v, dataAsFloat, 1, pixelsCount)
        vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount)
        vDSP_vfixu8(dataAsFloat, 1, t + 2, 4, pixelsCount)
        
        // Calculate blue components
        vDSP_vfltu8(t + 3, 4, dataAsFloat, 1, pixelsCount)
        vDSP_vsadd(dataAsFloat, 1, &v, dataAsFloat, 1, pixelsCount)
        vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount)
        vDSP_vfixu8(dataAsFloat, 1, t + 3, 4, pixelsCount)
        
        // Cleanup
        dataAsFloat.deallocate(capacity: pixelsCountInt)
        
        return bmContext.makeImage()
    }
}
