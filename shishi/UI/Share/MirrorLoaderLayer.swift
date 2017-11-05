//
//  MirrorLoaderLayer.swift
//  shishi
//
//  Created by tb on 2017/7/30.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class MirrorLoaderLayer: CALayer {
    public var image: UIImage?
    
    override init() {
        super.init()
        self.setupLayer()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        self.contentsScale = UIScreen.main.scale
    }
    
    override func draw(in ctx: CGContext) {
        
        guard let image = self.image else {
            return
        }
        
        let rotateImage = image.rotate(.downMirrored)!
        
        let drawHeight = self.frame.size.width * (image.size.height / image.size.width)
        
        let rowCount = Int(self.frame.size.height / drawHeight) + (Int(self.frame.size.height) % Int(drawHeight) == 0 ? 0 : 1)
        for index in 0..<rowCount {
            var drawImage = image
            let top = CGFloat(index) * drawHeight
            if index % 2 != 0 {
//                drawImage = UIImage(cgImage: drawImage.cgImage!, scale: drawImage.scale, orientation: .downMirrored)
                drawImage = rotateImage
            }
        
            let rect = CGRect(x: 0, y: top, width: self.frame.size.width, height: drawHeight)
            UIGraphicsPushContext(ctx)
            drawImage.draw(in: rect)
            UIGraphicsPopContext()
            
//            ctx.draw(drawImage.cgImage!, in: CGRect(x: 0, y: top, width: self.frame.size.width, height: drawHeight))
        }
    }
}
