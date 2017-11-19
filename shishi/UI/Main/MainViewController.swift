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
import FTPopOverMenu_Swift


class MainViewController: UIViewController , iCarouselDataSource, iCarouselDelegate
    
{
    
    var formerItems = [[Writting]]()
    
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
        let alertView1 = UIAlertAction(title: SSStr.Search.SEARCH_POETRY_HINT, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.navigationController?.pushViewController(SearchPoetryVC(), animated: true)
        }
        
        let alertView2 = UIAlertAction(title: SSStr.Search.SEARCH_AUTHOR_HINT, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.navigationController?.pushViewController(SearchAuthorVC(), animated: true)
        }
        
        let alertView3 = UIAlertAction(title: SSStr.Search.SEARCH_WRITING_HINT, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.navigationController?.pushViewController(SearchWritingVC(), animated: true)
        }
        
        let alertView4 = UIAlertAction(title: SSStr.Search.SEARCH_COLLECT_HINT, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.navigationController?.pushViewController(SearchUserCollectionPoetryVC(), animated: true)
        }

        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(alertView1)
        alertController.addAction(alertView2)
        alertController.addAction(alertView3)
        alertController.addAction(alertView4)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addClick(_ sender: Any) {
        self.navigationController?.pushViewController(SearchFormerVC(), animated: true)
    }
    @IBOutlet weak var btnRandom: UIButton!
    @IBAction func allClick(_ sender: AnyObject) {
        self.navigationController?.pushViewController(AllAuthorVC(), animated: true)
    }
    
    //随机一首诗
    @IBAction func randomClick(_ sender: Any) {
        self.navigationController?.pushViewController(RandomPoetryVC(), animated: true)
    }
    
    //智能对诗
    @IBAction func onBtnClick(_ sender: AnyObject) {
        self.navigationController?.pushViewController(DuishiVC(), animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        for i in 0 ... 3 {
//            items.append(i)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if !DBManager.shared.openDatabase(){
            NSLog("failed")
            return
        }
        

        self.reloadData()
        carousel.superview?.layoutIfNeeded()
        carousel.type = .linear
        carousel.currentItemIndex = carousel.numberOfItems-1
        
        
        FontsUtils.setFont(view)
        
        self.setupPopMenu()
        
        //test
        //        self.testShare()
        //        self.testDB()
//        self.testGenImage()
        
        _ = SSNotificationCenter.default.rx
            .notification(SSNotificationCenter.Names.addWritting)
            .subscribe(onNext: { [unowned self] notification in
            self.reloadData()
        })
        .addDisposableTo(self.rx_disposeBag)
        
        self.fixLanguage()
    }
    
    internal func setupPopMenu() {
        let configuration = FTConfiguration.shared
        configuration.menuRowHeight = 32
        configuration.menuWidth = 100
        configuration.textColor = UIColor.white
        configuration.textFont = FontsUtils.fontFromUserDefault(pointSize: 12)
        //        configuration.tintColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        //        configuration.borderColor = ...
        //        configuration.borderWidth = ...
        configuration.textAlignment = .center
        //            configuration.ignoreImageOriginalColor = ...;
        configuration.menuSeparatorColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        configuration.backgoundTintColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
    }
    
    func testDB() {
        
        //        self.addWrittingData()
        self.loadWrttingData()
        
    }
    
    func reloadData() {
        self.loadWrttingData()
        self.genFormers()
        self.carousel.reloadData()
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
    
    fileprivate func genFormers() {
        var items = [[Writting]]()
        //var formerIdArray = [Int]()
        for writting in self.writtingArray {
            let index = items.index(where: { (writtingArray) -> Bool in
                writtingArray.count > 0 && writtingArray[0].formerId == writting.formerId
            })
            
            if let index = index {
                items[index].append(writting)
            }
            else {
                items.append([writting])
            }
        }
        
        self.formerItems = items
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
    
    fileprivate func loadWrttingData() {
        //self.writtingArray = WritingDB.getAll()
        let array = Writting.allInstances()
        self.writtingArray = array as! [Writting]
        self.writtingArray = self.writtingArray.sorted(by: { (obj0, ojb1) -> Bool in
            return obj0.orderIndex < ojb1.orderIndex
        })
//        for item in self.writtingArray {
//            log.debug("id:\(item.id)")
//            log.debug("index:\(item.index)")
//            log.debug("title:\(item.title)")
//            log.debug("text:\(item.text)")
//            log.debug("formerId:\(item.formerId)")
//            log.debug("bgImg:\(item.bgImg)")
//            log.debug("author:\(item.author)")
//            log.debug("create_dt:\(item.create_dt)")
//            log.debug("update_dt:\(item.update_dt)")
//        }
        
    }
    
    fileprivate func dateString(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    //视图位置对应的数据位置
    //倒序显示
    fileprivate func formerIndex(with cardViewIndex: Int) -> Int {
        return formerItems.count - 1 - cardViewIndex
    }
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        //没有作品就显示介绍和主页
        if formerItems.count == 0 {
            return 1 + 1
        }
        else {
            return formerItems.count + 1
        }
    }

    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        //var label: UILabel
        var itemView: UIView
        
        let horizonalSpace:CGFloat = 40
        let cardViewWidth = self.carousel.bounds.size.width - horizonalSpace * 2
        
        //没有作品就显示介绍和主页
        
        //最后一个是主页
        var isMainIndex = false
        let hasFormer = self.formerItems.count != 0
        
        if !hasFormer && index == 0 {
            let introView = IntroView(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: self.carousel.bounds.size.height))
            return introView
        }
        
        
        if !hasFormer && index == 1 {
            isMainIndex = true
        }
        else if index == formerItems.count {
            isMainIndex = true
        }
        
        if !isMainIndex {
            let cardView = MainCardView(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: self.carousel.bounds.size.height))
            
            let formerIndex = self.formerIndex(with: index)
            cardView.tag = formerIndex
            cardView.delegate = self
            
            let formerItem = self.formerItems[formerIndex]
            let formerName = formerItem.first!.former.name!
            let updateDate = formerItem.last!.update_dt
            let dateString = self.dateString(with: updateDate)
//            let contentArray = formerItem.map({ (writting) -> String in
//                return writting.text
//            })
            let contentArray = formerItem
            cardView.setupData(cipai: formerName, dateString: dateString, contentArray: contentArray)
            
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
            return value * 1.1
        }
        return value
    }
    
    public func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
    }
}

extension MainViewController: MainCardViewDelegate {
    func mainCard(_ mainCardView: MainCardView, didTapCell cell: UIView, forRowAt index: Int) {
        var senderFrame = UIScreen.main.bounds
        senderFrame.origin.y = senderFrame.size.height / 2
        senderFrame.size.height = senderFrame.size.height / 2
        FTPopOverMenu.showFromSenderFrame(senderFrame: senderFrame,
                                          with: [SSStr.Share.SHARE, SSStr.Common.EDIT, SSStr.Common.DELETE],
                                          done: { [unowned self] (selectedIndex) -> () in
                                            
                                            let cardIndex = mainCardView.tag
                                            //var formerItem = self.formerItems[cardIndex]
                                            
                                            switch selectedIndex {
                                            case 0:
                                                self.showShareViewController(cardViewIndex: cardIndex, poetryIndex: index)
                                            case 2:
                                                self.deleteItem(cardViewIndex: cardIndex, poetryIndex: index)
                                                
                                            case 1:
                                                self.showEditViewController(cardViewIndex: cardIndex, poetryIndex: index)
                                                
                                            default:
                                                break
                                            }
        }) {
            
        }
    }
    
    func mainCard(_ mainCardView: MainCardView, didSwipeCardAt index: Int) {
        let cardIndex = mainCardView.tag
        guard self.formerItems[cardIndex].count > 0 else {
            return
        }
        
        let newWrittingIndex = Writting.indexValueForNewInstance()
        let writting = self.formerItems[cardIndex].remove(at: index)
        //writting.delete()
        writting.orderIndex = newWrittingIndex
        writting.save(nil)
        
        self.formerItems[cardIndex].append(writting)
        
        let viewIndex = self.formerIndex(with: cardIndex)
        self.carousel.reloadItem(at: viewIndex, animated: true)
    }
    
    internal func deleteItem(cardViewIndex: Int, poetryIndex: Int) {
        let writting = self.formerItems[cardViewIndex].remove(at: poetryIndex)
        writting.delete()
        if self.formerItems[cardViewIndex].count > 0 {
            let viewIndex = self.formerIndex(with: cardViewIndex)
            self.carousel.reloadItem(at: viewIndex, animated: true)
        }
        else {
            self.formerItems.remove(at: cardViewIndex)
            self.carousel.reloadData()
        }

    }
    
    internal func showShareViewController(cardViewIndex: Int, poetryIndex: Int) {
        let writting = self.formerItems[cardViewIndex][poetryIndex]
        let shareController = ShareEditVC()
        //shareController.poetry = poetry
        shareController.poetryTitle = writting.title
        shareController.poetryAuthor = writting.author ?? ""
        shareController.poetryContent = writting.text
        self.navigationController?.pushViewController(shareController, animated: true)
    }
    
    internal func showEditViewController(cardViewIndex: Int, poetryIndex: Int) {
        let writting = self.formerItems[cardViewIndex][poetryIndex]
        let viewController = EditVC(writting:writting)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

