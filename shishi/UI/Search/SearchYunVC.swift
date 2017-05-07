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
        items = FormerDB.getAll()
    }
    override func onItemClick(pos: Int) {
        let viewController = EditVC(former:items[pos] as! Former)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
