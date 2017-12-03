//
//  ChooseViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SearchPoetryVC: NormalSearchVC{
    
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
        let vc = RandomPoetryVC(poetry: items[pos] as! Poetry)
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let poetry = items[pos] as! Poetry
//        let author = AuthorDB.getAuthor(name: poetry.author)
//        let vc = AuthorPagerVC(author: author!, color: ColorDB.getAll()[0].toUIColor())
//        vc.firstPoetry = poetry
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
