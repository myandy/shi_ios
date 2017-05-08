//
//  ChooseViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit


class SearchYunVC: BaseSearchVC{
    override func loadData() {
        orginItems = FormerDB.getAll()
    }
    override func onItemClick(_ pos: Int) {
        let viewController = EditVC(former:items[pos] as! Former)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func getHint() -> String {
        return "搜索格律"
    }
}
