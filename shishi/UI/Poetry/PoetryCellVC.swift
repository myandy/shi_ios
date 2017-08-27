//
//  PoetryCellVC.swift
//  shishi
//
//  Created by andymao on 2017/5/8.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit



class PoetryCellVC : UIViewController {
    fileprivate var poetry:Poetry!
    
    lazy var poetryView: PoetryView = {
        let poetryView = PoetryView.loadNib()
        self.view.addSubview(poetryView)
        poetryView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        return poetryView
    }()
    
    lazy var pageLabel: UILabel! = {
        var pageLabel = UILabel()
        pageLabel.font = UIFont.systemFont(ofSize: 12)
        pageLabel.textColor = SSTheme.Color.whiteHint
        self.view.addSubview(pageLabel)
        pageLabel.numberOfLines = 0
        pageLabel.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(20)
        }
        return pageLabel
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }

    
    func refresh(poetry:Poetry,color:UIColor){
        
        NSLog("PoetryCell")
    }
    
    init(poetry:Poetry,color:UIColor,pager:String) {
        super.init(nibName: nil, bundle: nil)
        self.poetry = poetry
        self.poetryView.refresh(poetry: poetry,color:color)
        
        self.poetryView.actionHandel = { [unowned self] _ in
            self.showShareViewController()
        }
        self.pageLabel.text = pager
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateFont(pointSizeStep: CGFloat) {
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.introLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.contentLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.titleLabel)
        self.updateFont(pointSizeStep: pointSizeStep, label:  self.poetryView.authorLabel)

    }
    
    fileprivate func updateFont(pointSizeStep: CGFloat, label: UILabel) {
        label.font = UIFont(name: label.font.fontName, size: label.font.pointSize + pointSizeStep)
    }
    
    internal func showShareViewController() {
        let shareController = ShareEditVC()
        //shareController.poetry = poetry
        shareController.poetryTitle = self.poetry.title
        shareController.poetryAuthor = self.poetry.author
        shareController.poetryContent = self.poetry.poetry
        self.navigationController?.pushViewController(shareController, animated: true)
    }
}
