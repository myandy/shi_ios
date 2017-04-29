//
//  ChooseViewController.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SearchPoetryVC: BaseSearchVC{
    
    override func loadData() {
        items = PoetryDB.getRandom100()
    }
}
