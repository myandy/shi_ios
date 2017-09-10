//
//  SearchAuthorPager.swift
//  shishi
//
//  Created by andymao on 2017/9/11.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import UIKit

class SearchAuthorPagerVC: NormalSearchVC{
    
    var itemClick: ((_ pos:Int) -> Void)!

    
    public var author: String?
    
    override func loadData() {
        if let author = self.author {
            originItems = PoetryDB.getAll(author: author)
        }
        else {
            originItems = PoetryDB.getAll()
        }
    }
    
    override func getHint() -> String {
        return SSStr.Search.SEARCH_POETRY_HINT
    }
    
    override func onItemClick(_ pos: Int) {
        itemClick(pos)
    }
}
