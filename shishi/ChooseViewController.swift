//
//  ChooseViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
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
        
        items = YunDB.getAll()
        orginItems=items
        table.dataSource = self
        table.delegate = self
        table.register(BaseSearchTableViewCell.self, forCellReuseIdentifier: "ChooseCollectionViewCell")
   
        NSLog("yun size %d", items.count)
        table.reloadData()
        
        search.barTintColor = UIColor(intColor:StaticColor.BACK_COLOR)
        search.backgroundImage=UIImage()
        search.delegate=self

        table.backgroundColor = UIColor(intColor:StaticColor.BACK_COLOR)
        cancel.backgroundColor = UIColor(intColor:StaticColor.BACK_COLOR)
        divide.backgroundColor = UIColor(intColor:StaticColor.DIVIDE_COLOR)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText.isEmpty {
            self.items = self.orginItems
        }
        else {
            self.items = []
            for ctrl in self.orginItems {
                if ((ctrl as! Yun).name?.lowercased().contains(searchText.lowercased()))! {
                    self.items.add(ctrl)
                }
            }
        }
       
        self.table.reloadData()
    }
 

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = EditTabBarController(yun:items[indexPath.row] as! Yun)
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:BaseSearchTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "ChooseCollectionViewCell", for: indexPath)as! BaseSearchTableViewCell
        let data = items[indexPath.row] as! Yun
        cell.title.text = data.name
        cell.desc.text = String(format:"字数：%d", Int(data.count!))
        cell.backgroundColor=UIColor.clear
        FontsUtils.setFont(view: cell)
        return cell
    }
    
}
