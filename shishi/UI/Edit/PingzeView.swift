//
//  StoneView.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

public class PingzeView: UIView {
    var currentShapeType: Int = 0
    
    static let TYPE_PING = 1
    
    static let TYPE_ZHONG = 2
    
    static let TYPE_ZE = 3
    
    static let TYPE_PING_YUN = 4
    
    static let TYPE_ZE_YUN = 6
    
    static let TYPE_PING_YUN_CAN = 7
    
    static let TYPE_ZE_YUN_CAN = 9
    
    
    static let COLOR_PING = 0x8e8e8e
    
    static let COLOR_ZE = 0x666666
    
    static let COLOR_ZE_YUN = 0xb03b28
    
    static let COLOR_PING_YUN = 0x0070fb
    
    static let COLOR_YUN_GREEN = 0x8dc63f
    
    
    
    
    public init(frame: CGRect, shape: Int) {
        super.init(frame: frame)
        self.currentShapeType = shape
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func draw(_ rect: CGRect) {
        let center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0);
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.beginPath()
        ctx.setLineWidth(1)
        
        
        let radius: CGFloat = 5.0
        let endAngle: CGFloat = CGFloat(2 * Double.pi)
        
        switch currentShapeType {
        case PingzeView.TYPE_PING:
            ctx.setStrokeColor(UIColor.init(intColor: PingzeView.COLOR_PING).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.strokePath()
        case PingzeView.TYPE_ZHONG:
            ctx.setStrokeColor(UIColor.init(intColor: PingzeView.COLOR_PING).cgColor)
            ctx.addArc(center: center, radius: 3, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.strokePath()
            ctx.beginPath()
            ctx.setStrokeColor(UIColor.init(intColor: PingzeView.COLOR_PING).cgColor)
            ctx.addArc(center: center, radius: 6, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.strokePath()
        case PingzeView.TYPE_ZE:
            ctx.setFillColor(UIColor.init(intColor: PingzeView.COLOR_ZE).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.fillPath()
        case PingzeView.TYPE_PING_YUN:
            ctx.setFillColor(UIColor.init(intColor: PingzeView.COLOR_PING_YUN).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.fillPath()
        case PingzeView.TYPE_ZE_YUN:
            ctx.setFillColor(UIColor.init(intColor: PingzeView.COLOR_ZE_YUN).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.fillPath()
        case PingzeView.TYPE_PING_YUN_CAN:
            ctx.setStrokeColor(UIColor.init(intColor: PingzeView.COLOR_YUN_GREEN).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.strokePath()
        case PingzeView.TYPE_ZE_YUN_CAN:
            ctx.setFillColor(UIColor.init(intColor: PingzeView.COLOR_YUN_GREEN).cgColor)
            ctx.addArc(center: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
            ctx.fillPath()
        default: break
            
        }
        
        
        
    }
    
}
