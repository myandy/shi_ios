//
//  RandomPoetryViewController.swift
//  shishi
//
//  Created by andymao on 2016/12/24.
//  Copyright © 2016年 andymao. All rights reserved.
//

import UIKit
import RxSwift
import FTPopOverMenu_Swift

class RandomPoetryVC: UIViewController {
    
    @IBOutlet weak var randomBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    var poetryView: PoetryView!
    
    
    
    var poetry:Poetry!
    
    lazy var colors = ColorDB.getAll()
    
    var hasPoetry: Bool
    
    //当前显示字体大小
    internal var uifontOffset: CGFloat = 0
   
    override public func viewDidLoad() {
        poetryView = PoetryView.loadNib()
        self.view.addSubview(poetryView)
        poetryView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.bottom.equalTo(cancelBtn.snp.top)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        refresh()
        
       
        self.poetryView.actionHandel = { [unowned self] _ in
            self.onShareBtnClick()
        }
        
        //更新上次保存的字体大小
        let fontOffset = DataContainer.default.fontOffset
        if fontOffset != 0 {
            self.updateFont(pointSizeStep: fontOffset)
        }
    }
    
    init(poetry : Poetry) {
        self.poetry = poetry
        hasPoetry = true
        super.init(nibName: nil, bundle: nil)
        
    }
    
    convenience init() {
        self.init(poetry: Poetry())
        hasPoetry = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //解决从子页面返回时，字体大小没有刷新的问题
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.uifontOffset != DataContainer.default.fontOffset {
            let increaseSize = DataContainer.default.fontOffset - self.uifontOffset
            self.updateFont(pointSizeStep: increaseSize)
        }
    }

    func refresh(){
        if hasPoetry {
            hasPoetry = false
        }
        else {
            poetry = PoetryDB.getRandomPoetry()
        }
        let random = Int(arc4random_uniform(UInt32(colors.count)))
        poetryView.refresh(poetry: poetry,color:(colors[random]).toUIColor())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func onShareBtnClick() {
        let shareController = ShareEditVC()
        shareController.poetryTitle = self.poetry.title
        shareController.poetryAuthor = self.poetry.author
        shareController.poetryContent = self.poetry.poetry
        self.navigationController?.pushViewController(shareController, animated: true)
    }
}

//action
extension RandomPoetryVC {
    @IBAction func randomClick(_ sender: AnyObject) {
        refresh()
    }
    
    @IBAction func cancelClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onEditBtnClick(_ sender: AnyObject) {
        FTPopOverMenu.showForSender(sender: sender as! UIView,
                                    with: [SSStr.Share.INCREASE_FONTSIZE, SSStr.Share.REDUCE_FONTSIZE, SSStr.All.FAVORITE, SSStr.All.DIRECTORY, SSStr.All.COPY_CONTENT, SSStr.All.SPEAK_CONTENT, SSStr.All.AUTHOR_PEDIA, SSStr.All.CONTENT_PEDIA],
                                    done: { [unowned self] (selectedIndex) -> () in
                                        switch selectedIndex {
                                        case 0:
                                            _ = DataContainer.default.increaseFontOffset()
                                            self.updateFont(pointSizeStep: AppConfig.Constants.increaseFontStep)
                                        case 1:
                                            _ = DataContainer.default.reduceFontOffset()
                                            self.updateFont(pointSizeStep: -AppConfig.Constants.increaseFontStep)
                                        case 2:
                                            self.toggleCollection(poetry: self.poetry)
                                        case 3:
                                            SSControllerHelper.showDirectoryContoller(controller: self, author: self.poetry.author)
                                        case 4:
                                            
                                            UIPasteboard.general.string = StringUtils.contentTextFilter(poerityTitle: self.poetry.poetry)
                                            self.showToast(message: SSStr.Toast.COPY_SUCCESS)
                                        case 5:
                                            self.speech(poetry: self.poetry)
                                            
                                        case 6:
                                            SSControllerHelper.showBaikeContoller(controller: self, word: self.poetry.author)
                                        case 7:
                                            SSControllerHelper.showBaikeContoller(controller: self, word: self.poetry.title)
                                        default:
                                            break
                                        }
        }) {
            
        }
    }
    
    fileprivate func updateFont(pointSizeStep: CGFloat) {
        self.uifontOffset += pointSizeStep
        
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.introLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.contentLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.titleLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.authorLabel)
    }
    
    fileprivate func updateFont(pointSizeStep: CGFloat, label: UILabel) {
        label.font = UIFont(name: label.font.fontName, size: label.font.pointSize + pointSizeStep)
    }
    
    fileprivate func toggleCollection(poetry: Poetry) {
        let collectionArray = UserCollection.allInstances() as! [UserCollection]
        let itemIndex = collectionArray.index { (userCollection) -> Bool in
            return Int(userCollection.poetryId) == poetry.dNum && userCollection.poetryName == poetry.title
        }
        if let item = itemIndex {
            collectionArray[item].delete()
            self.showToast(message: SSStr.Toast.CANCEL_COLLECTION_SUCCESS)
        }
        else {
            let userCollection = UserCollection()
            userCollection.poetryId = Int64(poetry.dNum)
            userCollection.poetryName = poetry.title
            userCollection.userId = ""
            userCollection.save({
                
            })
            self.showToast(message: SSStr.Toast.COLLECTION_SUCCESS)
        }
    }
    
    fileprivate func speech(poetry: Poetry) {
        let title = StringUtils.titleTextFilter(poerityTitle: poetry.title)
        let content = StringUtils.contentTextFilter(poerityTitle: poetry.poetry)
        SpeechUtil.default.speech(text: title + content)
    }
}
