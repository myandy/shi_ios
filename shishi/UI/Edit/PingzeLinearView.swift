//
//  PingzeLinearView.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

public class PingzeLinearView : UIView{
    
    var code : String!
    
//    public init(frame: CGRect, code: String) {
//        self.code = code
//        super.init(frame: frame)
//    }
//    
//    public required  init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public override func draw(_ rect: CGRect) {
        if code == nil{
            return
        }
        for i in 0...code.characters.count-1{
            
            let index = code.index(code.startIndex, offsetBy: i)
            let c = code[index]
            
            NSLog(String(c))
            let frame = CGRect(x:i*20,y:0,width:20,height:20)
            if Utils.isPurnInt(string:String(c)){
                let pingze = PingzeView(frame: frame ,shape:Int(String(c))!)
                pingze.backgroundColor=UIColor.clear
                addSubview(pingze)
            }
            else{
                let label = UILabel()
                label.frame = frame
                label.text=String(c)
                label.textColor=UIColor.init(intColor: PingzeView.COLOR_ZE)
                addSubview(label)
            }
        }
    }
    
    public func refresh(code:String){
        self.code = code
        setNeedsDisplay()
    }
    
    public override func layoutSubviews() {
        
        self.backgroundColor = UIColor.clear

    }
    
     
    
    
}
