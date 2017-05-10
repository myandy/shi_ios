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
    
    var poetrys : NSMutableArray!
    
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

    
    lazy var collection: UICollectionView! = {
       
//        let cv = UICollectionViewLayout()
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)

        let collection = UICollectionView()
//        collection.collectionViewLayout=cv
        self.view.addSubview(collection)
        collection.snp.makeConstraints{ (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        collection.register(AllAuthorCell.self, forCellWithReuseIdentifier: poetryCellReuseIdentifier)
        //        collection.register(PoetryCell.self, forCellReuseIdentifier: authorCellReuseIdentifier)
        collection.dataSource=self
        collection.delegate=self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        
        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        
        for _ in 1 ... 5 {
            let vc = UIViewController()
            vc.view.backgroundColor = randomColor()
            controllers.append(vc)
        }
        
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
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
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setupUI()
//    }
    
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
        
        let backgroundView = UIImageView()
        backgroundView.image=UIImage(named:"launch_image")
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{ (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        
        collection.backgroundColor=UIColor.white
//        collection.reloadData()
//        collection.layoutIfNeeded()
    }
    
}

extension AuthorPagerVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.poetrys.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:PoetryCell = collection.dequeueReusableCell(withReuseIdentifier: poetryCellReuseIdentifier, for: indexPath) as! PoetryCell
         let data = self.poetrys[indexPath.row] as! Poetry
        
        cell.refresh(poetry: data,color:color)
        
        NSLog("collectionView")
        
        return cell
    }
}
