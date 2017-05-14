//
//  AllAuthorViewController.swift
//  shishi
//
//  Created by andymao on 2017/1/3.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class AllAuthorVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var sc: UISegmentedControl!
    
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBAction func scChanged(_ sender: Any) {
        
        switch sc.selectedSegmentIndex{
        case 0:
            if orderByNum {
                orderByNum = false
                loadData()
            }
        case 1:
            if !orderByNum {
                orderByNum = true
                loadData()
            }
        default:
            break
        }
    }
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var vf: UICollectionViewFlowLayout!
    
    @IBAction func cancelClick(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    @IBAction func chooseClick(_ sender: Any) {
        let alertController = UIAlertController(title: SSStr.CHOOSE_DYNASTY, message: "", preferredStyle: UIAlertControllerStyle.alert)
        for  i in 0 ... SSStr.DYNASTYS.count-1 {
            
            let alertView = UIAlertAction(title: SSStr.DYNASTYS[i], style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                
                if self.dynasty != i{
                    self.userDefault.set(i, forKey: "dynasty")
                    self.loadData()
                }
            }
            alertController.addAction(alertView)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    var items = [Author]()
    var dynasty:Int = 0
    let userDefault = UserDefaults.standard
    var orderByNum:Bool = false
    lazy var colors = {
        return ColorDB.getAll()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.dataSource = self
        cv.delegate = self
        cv.register(AllAuthorCell.self, forCellWithReuseIdentifier: "AllAuthorCell")
        let height=cv.bounds.height/2-50
        NSLog(String(describing: height))
        vf.itemSize = CGSize(width:70,height:height)
        loadData()
        
    }
    
    func getColor(index:Int)->Color{
        return colors[index%colors.count]
    }
    
    func loadData(){
        dynasty = userDefault.integer(forKey: "dynasty")
        items = AuthorDB.getAll(byPNum: orderByNum, dynasty: dynasty)
        cv.reloadData()
        cv.layoutIfNeeded()
        cv.setContentOffset(CGPoint(x:cv.contentSize.width-cv.bounds.size.width,y:0), animated: false)
        NSLog("AuthorDB %d",items.count)
    }
    
    override func viewWillLayoutSubviews() {
        //        cv.setContentOffset(CGPoint(x:cv.contentSize.width-cv.bounds.size.width,y:0), animated: false)
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.items.count
    }
    
    
    func getItemColor(_ index:Int)->UIColor{
        return getColor(index:self.items.count-1-index).toUIColor()
    }
    
    func getItemData(_ index:Int)->Author{
        return items[index%2 == 0 ? +1 : index-1]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AuthorPagerVC(author:getItemData(indexPath.row),color:getItemColor(indexPath.row))
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:AllAuthorCell  = cv.dequeueReusableCell(withReuseIdentifier: "AllAuthorCell", for: indexPath) as! AllAuthorCell
        
        let data = getItemData(indexPath.row)
        
        cell.lableDynasty.text =  data.dynasty![0..<1]
        
        let color = getItemColor(indexPath.row)
        cell.top.backgroundColor = color
        cell.lableDynasty.textColor = color
        cell.lableDynasty.layer.borderColor = color.cgColor
        
        cell.lableDynastyEn.text = data.enName
        cell.lableDynastyEn.textColor = UIColor.white
        
        cell.lableNum.text = String(format: "%03d", Int(data.pNum!))
        cell.lableNum.textColor = color
        
        cell.lableAuthor.text = data.name
        cell.lableAuthor.textColor = UIColor.white
        
        let options:NSStringDrawingOptions = .usesLineFragmentOrigin
        let boundingRect = data.name.boundingRect(with: CGSize(width:30,height: 0), options: options, attributes:[NSFontAttributeName:cell.lableAuthor.font], context: nil)
        cell.lableAuthor.frame = CGRect(x:35,y:48,width:32,height:(boundingRect.height))
        
        
        
        FontsUtils.setFont(cell)
        return cell
    }
    
}
