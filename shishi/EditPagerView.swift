//
//  EditPagerView.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation


public class EditPagerView : UIView,Nibloadable{
    
    
    
    @IBOutlet weak var ivTop: UIImageView!
    @IBOutlet weak var keyboard: UIImageView!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var dict: UIImageView!
    
    public static let bgimgList=["dust", "bg001",
                                 "bg002", "bg004", "bg006",
                                 "bg007", "bg011", "bg013",
                                 "bg072", "bg084", "bg096",
                                 "bg118"]
    
    
    public static let bgSmallimgList = ["dust",
                                        "bg001_small" ,"bg002_small",
                                        "bg004_small", "bg006_small",
                                        "bg007_small", "bg011_small",
                                        "bg013_small", "bg072_small",
                                        "bg084_small", "bg096_small",
                                        "bg118_small"]
    
    public var writing: Writing?
    

    public override func draw(_ rect: CGRect) {
        if writing==nil{
            writing=Writing()
        }
        
        if Utils.isPurnInt(string:(writing?.bgimg)!){
            ivTop.image=UIImage(named: EditPagerView.bgimgList[Int((writing?.bgimg)!)!])
        }
        
        let linearView = PingzeLinearView(frame: CGRect(x:10,y:70,width:300,height:20), code: "12345,6789")
        addSubview(linearView)

    }
  
    
}
