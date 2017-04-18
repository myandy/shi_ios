//
//  EditTabBarController.swift
//  shishi
//
//  Created by andymao on 2017/4/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class EditTabBarController: UITabBarController {
    
    
    var writing: Writing!
    
    public init(writing:Writing) {
        self.writing = writing
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(yun:Yun) {
        self.writing = Writing()
        writing.yun=yun
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建tabbar的子控制器
        self.creatSubViewControllers()
        
        self.tabBar.clipsToBounds=true
        self.tabBar.backgroundImage=UIImage(named: "launch_image")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            self.navigationController?.popViewController(animated: true)
        default: break
            
        }
    }
    func exitClick(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func finishClick(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func creatSubViewControllers(){
        let exit = UIButton(frame:CGRect(x: 0, y: 0, width: 70, height: 0))
        exit.setImage(UIImage(named:"cancel"),for:UIControlState.normal)
        self.tabBar.addSubview(exit)
        exit.snp.makeConstraints { (make) in
            make.top.equalTo(tabBar)
            make.bottom.equalTo(tabBar)
            make.left.equalTo(tabBar)
        }
        exit.addTarget(self, action: #selector(exitClick), for: UIControlEvents.touchUpInside)
        
        let finish = UIButton(frame:CGRect(x: 0, y: 0, width: 70, height: 0))
        finish.setImage(UIImage(named:"done"),for:UIControlState.normal)
        self.tabBar.addSubview(finish)
        finish.snp.makeConstraints { (make) in
            make.top.equalTo(tabBar)
            make.bottom.equalTo(tabBar)
            make.right.equalTo(tabBar)
        }
        finish.addTarget(self, action:  #selector(finishClick), for: UIControlEvents.touchUpInside)
        
        
        let firstVC  = EditViewController (writing:writing)
        let item1 : UITabBarItem = UITabBarItem (title: "", image: UIImage(named: "layout_bg_edit"), selectedImage: UIImage(named: "layout_bg_edit_selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        firstVC.tabBarItem = item1
        item1.imageInsets=UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)

        
        let secondVC = EditViewController (writing:writing)
        let image2 = UIImage(named: "layout_bg_paper_selected")
        
        let item2 : UITabBarItem = UITabBarItem (title: "", image: UIImage(named: "layout_bg_paper"), selectedImage:image2?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        secondVC.tabBarItem = item2
        
        let otherVC = EditViewController (writing:writing)
        let item3 : UITabBarItem = UITabBarItem (title: "", image: UIImage(named: "layout_bg_album"), selectedImage: UIImage(named: "layout_bg_album_sel")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        otherVC.tabBarItem = item3
//        item3.imageInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        let tabArray = [firstVC,secondVC,otherVC]
        self.viewControllers = tabArray
    }
    
    
}
