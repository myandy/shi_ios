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



class MainViewController: UIViewController , iCarouselDataSource, iCarouselDelegate
    
{
    
    var items: [Int] = []
    
    var writtingArray = [Writting]()
    
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
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let alertView1 = UIAlertAction(title: "搜索诗", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.navigationController?.pushViewController(SearchPoetryVC(), animated: true)
        }
        
        let alertView2 = UIAlertAction(title: "搜索诗人", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.navigationController?.pushViewController(SearchAuthorVC(), animated: true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(alertView1)
        alertController.addAction(alertView2)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addClick(_ sender: Any) {
        self.navigationController?.pushViewController(SearchFormerVC(), animated: true)
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
        for i in 0 ... 3 {
            items.append(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !DBManager.shared.openDatabase(){
            NSLog("failed")
            return
        }
        

        
        carousel.superview?.layoutIfNeeded()
        carousel.type = .linear
        carousel.currentItemIndex = carousel.numberOfItems-1
        
        
        FontsUtils.setFont(view)
        
        //test
        //        self.testShare()
        //        self.testDB()
//        self.testGenImage()
        
    }
    
    func testDB() {
        
        //        self.addWrittingData()
        self.loadWrttingData()
        
    }
    
    func addWrittingData() {
        for i in 0...10 {
            let writting = Writting()
//            writting.id = i + 1000
            writting.title = "title\(i)"
            writting.text = "text\(i)"
            writting.formerId = i + 10
            writting.bgImg = 0
            writting.author = "author\(i)"
            //WritingDB.addWriting(writing: writting)
            writting.save() {
                
            }
        }
    }
    
    func testShare() {
        SSShareUtil.default.shareToSystem(controller: self, image: UIImage(named: "back")!)
    }
    
    
    func testGenImage() {
        let image = SSImageUtil.genShiImage(UIImage(named:"bg001"), "title 11", content: "content\n0033333333\n444444444444444444445555555555555555555522222222222222222222223333333333333\nqqqqqqqqqqqqqqqwwwwwwwwwwwwwwwwww")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden=true
        
    }
    
    private func loadWrttingData() {
        //self.writtingArray = WritingDB.getAll()
        let array = Writting.allInstances()
        self.writtingArray = array as! [Writting]
        for item in self.writtingArray {
            log.debug("id:\(item.id)")
            log.debug("title:\(item.title)")
            log.debug("text:\(item.text)")
            log.debug("formerId:\(item.formerId)")
            log.debug("bgImg:\(item.bgImg)")
            log.debug("author:\(item.author)")
            log.debug("create_dt:\(item.create_dt)")
            log.debug("update_dt:\(item.update_dt)")
        }
        
    }
    
    
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        //var label: UILabel
        var itemView: UIView
        
        
        if index < items.count - 1 {
            //            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 800))
            //            imageView.image = UIImage(named: "bg001.jpg")
            //            imageView.contentMode = .center
            //
            //            label = UILabel(frame: imageView.bounds)
            //            label.textAlignment = .center
            //            label.tag = 1
            //            label.text="诗词"
            //            imageView.addSubview(label)
            //            itemView=imageView
            let cardView = MainCardView(frame: CGRect(x: 0, y: 0, width: convertWidth(pix: 400), height: self.carousel.bounds.size.height))
            
            cardView.setupData(cipai: "临江仙", dateString: "17-05-07", contentArray: ["ABCDEFG\nrewqre\nfds", "1234567"])
            
            itemView = cardView
            //            itemView.backgroundColor = UIColor.white
            //            log.debug(self.carousel.bounds.size.height)
        }
        else{
            if mainView == nil{
                mainView = UINib(nibName: "MainView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
            }
            itemView = mainView
            
            
        }
        return itemView
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.2
        }
        return value
    }
    
}

