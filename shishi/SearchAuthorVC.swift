//
//  SearchAuthorVC.swift
//  shishi
//
//  Created by andymao on 2017/4/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SearchAuthorVC: BaseSearchVC {

    override func loadData() {
        items = AuthorDB.getAll(byPNum: false, dynasty: 0)
    }
}
