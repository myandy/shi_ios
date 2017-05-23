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

class AuthorPagerVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var poetrys = [Poetry]()
    
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

    var author : Author!
    var color : UIColor!
    
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


