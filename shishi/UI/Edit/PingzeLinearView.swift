//
//  PingzeLinearView.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit

public class PingzeLinearView : UIView{
    
    var code : String!
    
//    public override func draw(_ rect: CGRect) {
//
//    }
    
    public func refresh(code:String){
        
        self.backgroundColor = UIColor.clear
        
        self.code = code
        //setNeedsDisplay()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        if code.isEmpty {
            return
        }
        for i in 0...code.trimmingCharacters(in:NSCharacterSet.newlines).characters.count-1{
            
            let index = code.index(code.startIndex, offsetBy: i)
            let c = code[index]
            
            NSLog(String(c))
            let frame = CGRect(x:i*20,y:0,width:20,height:20)
            if StringUtils.isPurnInt(string:String(c)){
                let pingze = PingzeView(frame: frame ,shape:Int(String(c))!)
                pingze.backgroundColor=UIColor.clear
                addSubview(pingze)
                pingze.snp.makeConstraints({ (maker) in
                    maker.height.width.equalTo(20)
                    maker.top.equalToSuperview()
                    maker.leading.equalToSuperview().offset(i * 20)
                })
            }
            else{
                let label = UILabel()
                label.frame = frame
                label.text=String(c)
                label.textColor=UIColor.init(hex6: PingzeView.COLOR_ZE)
                addSubview(label)
                label.snp.makeConstraints({ (maker) in
                    maker.height.width.equalTo(20)
                    maker.top.equalToSuperview()
                    maker.leading.equalToSuperview().offset(i * 20)
                })
            }
        }
    }
    
//    public override func layoutSubviews() {
//
//    }
}
