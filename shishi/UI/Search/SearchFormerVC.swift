//
//  SearchFormerVC.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit


class SearchFormerVC: NormalSearchVC{
    override func loadData() {
        originItems = FormerDB.getAll().sorted(by: { (former0, former1) -> Bool in
            return former0.id > former1.id
        })
    }
    override func onItemClick(_ pos: Int) {
        let viewController = EditVC(former:items[pos] as! Former)
        self.navigationController?.pushViewController(viewController, animated: true)
        //删除当前页面
        let index = self.navigationController!.viewControllers.index(of: self)
        self.navigationController!.viewControllers.remove(at: index!)
    }
    
    override func getHint() -> String {
        return "搜索格律"
    }
}
