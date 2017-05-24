//
//  NormalSearchVC.swift
//  shishi
//
//  Created by andymao on 2017/5/20.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class NormalSearchVC : BaseSearchVC {
    
    var items: Array<Any>!
    var originItems: Array<Any>!
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NormalSearchCell.self, forCellReuseIdentifier: "NormalSearchCell")
        tableView.backgroundColor = SSTheme.Color.backColor
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.lineView.snp.bottom)
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = getHint()
        
        tableView.rowHeight = 60
        loadData()
        items = originItems
    }
    
}

extension NormalSearchVC {
    public  func loadData(){
        
    }
    
    public func onItemClick(_ pos:Int){
        
    }
    
    public func getHint()->String{
        return ""
    }
}

extension NormalSearchVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // 没有搜索内容时显示全部组件
        if searchText.isEmpty {
            self.items = self.originItems
        }
        else {
            self.items = []
            for ctrl in self.originItems {
                if ((ctrl as! SearchModel).getTitle().lowercased().contains(searchText.lowercased())) {
                    self.items.append(ctrl)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
}

extension NormalSearchVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemClick(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:NormalSearchCell = tableView.dequeueReusableCell(withIdentifier: "NormalSearchCell", for: indexPath) as! NormalSearchCell
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}
