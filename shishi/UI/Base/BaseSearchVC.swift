//
//  BaseSearchVC.swift
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
        
        let nibNameOrNil = String?("BaseSearchVC")
        
    
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var divide: UIView!
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBAction func cancelClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var items: Array<Any>!
    var orginItems: Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BaseSearchCell.self, forCellReuseIdentifier: "BaseSearchCell")
        
        searchBar.barTintColor = UIColor(intColor: SSTheme.ColorInt.BACK)
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.placeholder = getHint()
        
        tableView.backgroundColor = UIColor(intColor:SSTheme.ColorInt.BACK)
        cancel.backgroundColor = UIColor(intColor:SSTheme.ColorInt.BACK)
        divide.backgroundColor = UIColor(intColor:SSTheme.ColorInt.DIVIDE)
        
        loadData()
        items = orginItems
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BaseSearchVC {
    public  func loadData(){
        
    }
    
    public func onItemClick(_ pos:Int){
        
    }
    
    public func getHint()->String{
        return ""
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
                    self.items.append(ctrl)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
}

extension BaseSearchVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemClick(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:BaseSearchCell  = tableView.dequeueReusableCell(withIdentifier: "BaseSearchCell", for: indexPath)as! BaseSearchCell
        let data = items[indexPath.row] as! SearchModel
        cell.title.text = data.getTitle()
        
        if data.getDesc().isEmpty{
            cell.desc.removeFromSuperview()
        }
        else{
            cell.desc.text = data.getDesc()
        }
        
        cell.hint.text = data.getHint()
        cell.backgroundColor = UIColor.clear
        FontsUtils.setFont(cell)
        return cell
    }
}

extension BaseSearchVC{
    
}
