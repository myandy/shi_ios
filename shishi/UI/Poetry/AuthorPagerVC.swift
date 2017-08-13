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
        
        for poetry in poetrys {
            let vc = PoetryCellVC(poetry:poetry,color:color)
            controllers.append(vc)
        }
        
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        if UserDefaults.standard.value(forKey: UserDefaultsKeyLoadTimes) == nil {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKeyLoadTimes)
            self.showTip()
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
                    self.tipView.removeFromSuperview()
                })
                .addDisposableTo(self.rx_disposeBag)
            
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
}


