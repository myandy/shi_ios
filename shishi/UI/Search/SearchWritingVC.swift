//
//  SearchWritingVC.swift
//  shishi
//
//  Created by andymao on 2017/8/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SearchWritingVC: NormalSearchVC{
    override func loadData() {
        originItems =  Writting.allInstances()

    }
    override func onItemClick(_ pos: Int) {
        let writting = self.originItems[pos] as! Writting
        let viewController = EditVC(writting: writting)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func getHint() -> String {
        return SSStr.Search.SEARCH_WRITING_HINT
    }
}
