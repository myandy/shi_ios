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
        items = YunDB.getAll()
    }
    override func onItemClick(pos: Int) {
        let viewController = EditVC(yun:items[pos] as! Yun)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
