//
//  EditViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

public class EditViewController: UIViewController {
    
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
    
    var writing: Writing?
    
    var yun:Yun?
    
    
    public init(writing:Writing) {
        self.writing = writing
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(yun:Yun) {
        self.writing = Writing()
        self.yun=yun
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if writing==nil{
            writing=Writing()
        }
        
        if Utils.isPurnInt(string:(writing?.bgimg)!){
            ivTop.image=UIImage(named: EditViewController.bgimgList[Int((writing?.bgimg)!)!])
        }
        
        let linearView = PingzeLinearView(frame: CGRect(x:10,y:70,width:300,height:20), code: "12345,6789")
        self.view.addSubview(linearView)
        // Do any additional setup after loading the view.
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
