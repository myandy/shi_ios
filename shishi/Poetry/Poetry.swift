//
//  Poetry.swift
//  shishi
//
//  Created by andymao on 2016/12/20.
//  Copyright © 2016年 andymao. All rights reserved.
//

import Foundation
import FMDB

class Poetry{
    var poetry: String?
    var author: String?
    var intro: String?
    var title: String?
    var dNum: Int32?
}

extension Poetry : SearchModel{
    func getTitle() -> String {
        return title!
    }
    
    func getDesc() -> String {
        return poetry!
    }
}

class PoetryDB{
    
    private static let TABLE_NAME="t_poetry"
    
    private static let BY_PNUM = " order by p_num desc"
    
    private class func getList(rs: FMResultSet) -> NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Poetry()
            model.poetry = rs.string(forColumn: "d_poetry")
            model.author = rs.string(forColumn: "d_author")
            model.intro = rs.string(forColumn: "d_intro")
            model.title = rs.string(forColumn: "d_title")
            model.dNum = rs.int(forColumn: "d_num")
            array.add(model)
        }
        return array
    }
    
    public class func getRandom100() -> NSMutableArray! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" order by random() limit 100")
        var array = NSMutableArray()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getList(rs: rs)!
        }
        catch{
        }
        
        return array
        
    }
    
    public class func getRandomPoetry() -> Poetry! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" order by random() limit 1")
        var array = NSMutableArray()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getList(rs: rs)!
        }
        catch{
        }
        if array.count>0{
            return array[0] as! Poetry
        }
        return nil
        
    }
    
    
    public class func getAll(author: String) -> NSMutableArray! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" where d_author = '").appending(author).appending("'")
        var array = NSMutableArray()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getList(rs: rs)!
        }
        catch{
        }
        
        return array
        
    }
}
