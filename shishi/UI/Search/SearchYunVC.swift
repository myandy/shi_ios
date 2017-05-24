//
//  SearchYunVC.swift
//  shishi
//
//  Created by andymao on 2017/5/20.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit


let SEARCH_BAR_HEIGHT = 50

class SearchYunVC : BaseSearchVC {

    var yunList = [Yun]()
    
    static var searchString: String!
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchYunCell.self, forCellReuseIdentifier: "SearchYunCell")
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
        searchBar.placeholder = String(format:SSStr.Search.YUN_SEARCH_HINT, SSStr.Setting.YUN_CHOICES[UserDefaultUtils.getYunshu()])
        searchBar.text = SearchYunVC.searchString
        doSearch(SearchYunVC.searchString)
        self.tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func doSearch(_ searchText:String?){
        if searchText != nil {
            let word = getLastChinese(searchText!)
            if word != nil {
                yunList = YunDB.getSameYun(word!)
                tableView.reloadData()
            }

        }
    }
    
}

extension SearchYunVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        SearchYunVC.searchString = searchText
        doSearch(searchText)
    }
}

extension SearchYunVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yunList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:SearchYunCell = tableView.dequeueReusableCell(withIdentifier: "SearchYunCell", for: indexPath) as! SearchYunCell
        let data = yunList[indexPath.row]
        cell.title.text = data.section_desc
        cell.content.text = data.glys
        
        FontsUtils.setFont(cell)
        return cell
    }
}


private func getLastChinese(_ string :String) -> Character?{
    for value in string.characters.reversed() {
        if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
            return value
        }
    }
    return nil
}



