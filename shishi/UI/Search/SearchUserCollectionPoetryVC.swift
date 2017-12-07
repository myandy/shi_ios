//
//  SearchUserCollectionPoetryVC.swift
//  shishi
//
//  Created by tb on 2017/8/28.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SearchUserCollectionPoetryVC: SearchPoetryVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadData() {
        let collectionArray = UserCollection.allInstances() as! [UserCollection]
        originItems = PoetryDB.getAll().filter({ (poetry) -> Bool in
            return collectionArray.contains(where: { (userCollection) -> Bool in
                return Int(userCollection.poetryId) == poetry.dNum && userCollection.poetryName == poetry.title
            })
        })
 
    }
    
    override func getHint() -> String {
        return SSStr.Search.SEARCH_COLLECT_HINT
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
