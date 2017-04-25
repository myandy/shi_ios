//
//  ChooseViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class BaseSearchVC: UIViewController{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    // to do 1.重名名完善2.搜索继承逻辑3.editView多个页面显示，是否使用collectionView
    
    convenience init() {
        
        var nibNameOrNil = String?("BaseSearchVC")
        
        //        //考虑到xib文件可能不存在或被删，故加入判断
        //
        //        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil{
        //
        //            nibNameOrNil = nil
        //
        //        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var divide: UIView!
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBAction func cancelClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var items:NSMutableArray=[]
    var orginItems:NSMutableArray=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        table.dataSource = self
        table.delegate = self
        table.register(BaseSearchCell.self, forCellReuseIdentifier: "BaseSearchCell")
        
        search.barTintColor = UIColor(intColor: SSTheme.Color.BACK_COLOR)
        search.backgroundImage=UIImage()
        search.delegate=self
        
        table.backgroundColor = UIColor(intColor:SSTheme.Color.BACK_COLOR)
        cancel.backgroundColor = UIColor(intColor:SSTheme.Color.BACK_COLOR)
        divide.backgroundColor = UIColor(intColor:SSTheme.Color.DIVIDE_COLOR)
        
        loadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
}

extension BaseSearchVC {
    public func loadData(){
         orginItems=items
    }
    
    public func onItemClick(pos:Int){
        
    }
}

extension BaseSearchVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText.isEmpty {
            self.items = self.orginItems
        }
        else {
            self.items = []
            for ctrl in self.orginItems {
                if ((ctrl as! SearchModel).getTitle().lowercased().contains(searchText.lowercased())) {
                    self.items.add(ctrl)
                }
            }
        }
        
        self.table.reloadData()
    }

}

extension BaseSearchVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemClick(pos: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:BaseSearchCell  = tableView.dequeueReusableCell(withIdentifier: "BaseSearchCell", for: indexPath)as! BaseSearchCell
        let data = items[indexPath.row] as! SearchModel
        cell.title.text = data.getTitle()
        cell.desc.text = data.getDesc()
        cell.backgroundColor=UIColor.clear
        FontsUtils.setFont(view: cell)
        return cell
    }
}

extension BaseSearchVC{
    
}
