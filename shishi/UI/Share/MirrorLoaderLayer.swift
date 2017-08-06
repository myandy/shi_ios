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
        
        var drawImage = image
        
        let rowCount = Int(self.frame.size.height / image.size.height) + (Int(self.frame.size.height) % Int(image.size.height) == 0 ? 0 : 1)
        for index in 0..<rowCount {
            let top = CGFloat(index) * drawImage.size.height
            if index % 2 != 0 {
//                drawImage = UIImage(cgImage: drawImage.cgImage!, scale: drawImage.scale, orientation: .downMirrored)
                drawImage = image.rotate(.downMirrored)
            }
        
            ctx.draw(drawImage.cgImage!, in: CGRect(x: 0, y: top, width: self.frame.size.width, height: drawImage.size.height))
        }
    }
}
