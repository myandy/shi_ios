//
//  AuthorPagerVC.swift
//  shishi
//
//  Created by andymao on 2017/5/8.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit
import iCarousel
import FTPopOverMenu_Swift


private let poetryCellReuseIdentifier = "poetryCellReuseIdentifier"

private let authorCellReuseIdentifier = "authorCellReuseIdentifier"

private let UserDefaultsKeyLoadTimes = "UserDefaultsKeyLoadTimes"

class AuthorPagerVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var poetrys = [Poetry]()
    
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

    var author : Author!
    var color : UIColor!
    
    fileprivate lazy var tipView:UIView = {
        let tipView = UIView()
        return tipView
    }()
    
    fileprivate lazy var tipTitleView:UILabel = {
        let titleView = UILabel()
        titleView.text = SSStr.Tips.AUTHOR_SLIDE
        titleView.textColor = UIColor.white
        return titleView
    }()
    
    fileprivate lazy var tipImageView:UIImageView = {
        let imageView = UIImageView()
        var images = [UIImage]()
        let formatName = "left_slip_guide_%03d"
        for index in 0...24 {
            let imageName = String(format: formatName, index)
            images.append(UIImage(named: imageName)!)
        }
        imageView.animationImages = images
        return imageView
    }()
    
    internal var editBtn: UIButton!
    
    internal lazy var bottomBar: UIView = {
        let bottomBar = UIView()
        return bottomBar
    }()
    
    //滑动到最左边退出当前页面
    var canSwapExit = true
    
    init(author : Author,color : UIColor) {
        self.author = author
        self.color = color
        poetrys = PoetryDB.getAll(author: author.name!)
        NSLog("poetry size %d %@", poetrys.count,author.name!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        
        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        
        if self.canSwapExit {
            let imageViewController = ImageViewContoller()
            let parentImage = SSImageUtil.image(with: self.parent!.view)
            imageViewController.image = parentImage
            controllers.append(imageViewController)
        }
        
        for poetry in poetrys {
            let vc = PoetryCellVC(poetry:poetry,color:color)
            controllers.append(vc)
        }
        
        //pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        
        self.setupBottomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        if self.canSwapExit {
            pageController.setViewControllers([controllers[1]], direction: .forward, animated: false)
        }
        
        
        if UserDefaults.standard.value(forKey: UserDefaultsKeyLoadTimes) == nil {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKeyLoadTimes)
            self.showTip()
        }
        
    }
    
    internal func setupBottomView() {
        self.view.addSubview(self.bottomBar)
        
        self.bottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(convertWidth(pix: 100))
        }
        
        let cancleBtn = UIButton()
        self.bottomBar.addSubview(cancleBtn)
        cancleBtn.setImage(UIImage(named:"cancel"), for: .normal)
        cancleBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(convertWidth(pix: 20))
            make.bottom.equalToSuperview().offset(convertWidth(pix: -20))
            make.height.width.equalTo(convertWidth(pix: 90))
        }
        cancleBtn.addTapHandler { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        
        self.editBtn = UIButton()
        self.bottomBar.addSubview(editBtn)
        editBtn.setImage(UIImage(named:"setting"), for: .normal)
        editBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(convertWidth(pix: -20))
            make.bottom.height.width.equalTo(cancleBtn)
        }
        editBtn.addTapHandler { [unowned self] in
            self.showMenu()
        }
        
    }
    
    fileprivate func showTip() {
        if self.tipView.superview == nil {
            self.view.addSubview(self.tipView)
            self.tipView.snp.makeConstraints({ (make) in
                make.right.centerY.equalToSuperview()
            })
            
            self.tipView.addSubview(self.tipImageView)
            self.tipImageView.snp.makeConstraints({ (make) in
                make.centerX.top.equalToSuperview()
                make.width.height.equalTo(120)
            })
            self.tipImageView.startAnimating()
            
            self.tipView.addSubview(self.tipTitleView)
            self.tipTitleView.snp.makeConstraints({ (make) in
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(self.tipImageView.snp.bottom)
            })
    
            let tapGuesture = UITapGestureRecognizer()
            self.tipView.addGestureRecognizer(tapGuesture)
            tapGuesture.rx.event
                .subscribe(onNext: { [unowned self] _ in
                    self.hideTip()
                })
                .addDisposableTo(self.rx_disposeBag)
            
        }
    }
    
    fileprivate func hideTip() {
        if self.tipView.superview != nil {
            self.tipView.removeFromSuperview()
        }
        
    }
    
    fileprivate func showMenu() {
        FTPopOverMenu.showForSender(sender: self.editBtn,
                                    with: [SSStr.Share.INCREASE_FONTSIZE, SSStr.Share.REDUCE_FONTSIZE],
                                    done: { [unowned self] (selectedIndex) -> () in
                                        switch selectedIndex {
                                        case 0:
                                            break
                                        default:
                                            break
                                        }
        }) {
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            self.hideTip()
            
            if self.canSwapExit && pageViewController.viewControllers!.first is ImageViewContoller {
                self.navigationController?.popViewController(animated: false)
            }
        }
        
        
    }
}

class ImageViewContoller: UIViewController {
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: self.image)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


