//
//  ViewController.swift
//  shishi
//
//  Created by andymao on 16/11/9.
//  Copyright © 2016年 andymao. All rights reserved.
//

import UIKit
import SnapKit
import iCarousel
import UMCommunitySDK



class ViewController: UIViewController , iCarouselDataSource, iCarouselDelegate
    
{
    
    var items: [Int] = []
    
    @IBOutlet var carousel: iCarousel!
    var mainView: UIView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var btnCommunity: UIButton!
    @IBAction func communityClick(_ sender: Any) {
        
        self.present(UMCommunityUI.navigationViewController(), animated: true,completion: nil)
    }
    @IBOutlet weak var btnAll: UIButton!
    @IBAction func settingClick(_ sender: Any) {
        self.navigationController?.pushViewController(SettingVC(), animated: true)
    }
    
    @IBAction func searchClick(_ sender: Any) {
        let alertController = UIAlertController(title: "搜索", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertView1 = UIAlertAction(title: "搜索诗", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.navigationController?.pushViewController(SearchPoetryVC(), animated: true)
         }
        let alertView2 = UIAlertAction(title: "搜索诗人", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.navigationController?.pushViewController(SearchAuthorVC(), animated: true)
        }
        alertController.addAction(alertView1)
        alertController.addAction(alertView2)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addClick(_ sender: Any) {
        self.navigationController?.pushViewController(SearchYunVC(), animated: true)
    }
    @IBOutlet weak var btnRandom: UIButton!
    @IBAction func allClick(_ sender: AnyObject) {
         self.navigationController?.pushViewController(AllAuthorVC(), animated: true)
     }
    
    @IBAction func randomClick(_ sender: Any) {
        self.navigationController?.pushViewController(RandomPoetryVC(), animated: true)
    }
    
    @IBAction func onBtnClick(_ sender: AnyObject) {
        self.navigationController?.pushViewController(DuishiVC(), animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0 ... 9 {
            items.append(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !DBManager.shared.openDatabase(){
            NSLog("failed")
            return
        }
        
        carousel.type = .linear
        carousel.currentItemIndex=carousel.numberOfItems-1
        
        
        FontsUtils.setFont(view: view)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        FontsUtils.setFont(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden=true
        
    }
    
    
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIView
        

        if(index<items.count-1){
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 800))
            imageView.image = UIImage(named: "bg001.jpg")
            imageView.contentMode = .center
            
            label = UILabel(frame: imageView.bounds)
            label.textAlignment = .center
            label.tag = 1
            label.text="诗词"
            imageView.addSubview(label)
            itemView=imageView
            
        }
        else{
            if mainView==nil{
                mainView = UINib(nibName: "MainView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
            }
            itemView=mainView
            
          
        }
        return itemView
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.2
        }
        return value
    }
    
    

    //
    //    func loadSubViews() {
    ////        scrollView.clipsToBounds = false
    //
    //        self.loadHomeView()
    //
    //        //self.mainView =  UINib(nibName: "MainView", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! MainView
    //
    //        let screenWidth = UIScreen.main.bounds.width
    //        let pageWidth = screenWidth
    //
    //        for index in 0...colors.count-1 {
    //
    //            var subView:UIView!
    //
    //            let subViewFrame: CGRect = CGRect(x: CGFloat(index) * pageWidth, y: 0, width: pageWidth, height: self.view.bounds.height)
    //
    //            if(index==colors.count-1){
    //                subView = self.mainView
    //            }
    //            else {
    //                subView = UIView()
    //                subView.backgroundColor=colors[index]
    //            }
    //            self.scrollView.addSubview(subView)
    //            subView.frame = subViewFrame
    //
    //
    //        }
    //
    //        self.scrollView.contentSize = CGSize.init(width: pageWidth * CGFloat(colors.count), height: self.frame.size.height)
    //    }
    //
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
}

