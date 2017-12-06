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
    var poetry: String!
    var author: String!
    var intro: String!
    var title: String!
    var dNum: Int!
}

extension Poetry : SearchModel{
    func getTitle() -> String {
        return title
    }
    
    func getDesc() -> String {
        return poetry
    }
    
    func getHint() -> String {
        return author
    }
}

class PoetryDB{
    
    private static let TABLE_NAME = "t_poetry"
    
    private static let BY_PNUM = " order by p_num desc"
    
    private class func getArray(_ rs: FMResultSet)->[Poetry]{
        var array = [Poetry]()
        while rs.next() {
            let model = Poetry()
            model.poetry = rs.string(forColumn: "d_poetry")
            model.author = rs.string(forColumn: "d_author")
            model.intro = rs.string(forColumn: "d_intro")
            model.title = rs.string(forColumn: "d_title")
            model.dNum = Int(rs.int(forColumn: "d_num"))
            array.append(model)
        }
        return array
    }

    public class func getRandom100()->[Poetry]! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" order by random() limit 100")
        var array = [Poetry]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
        }
        catch{
            print(error)
        }
        
        return array
        
    }
    
    public class func getRandomPoetry()->Poetry! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" order by random() limit 1")
        var array = [Poetry]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
        }
        catch{
            print(error)
        }
        if array.count > 0{
            return array[0]
        }
        return nil
        
    }
    
    public class func getAll(author:String)-> [Poetry] {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" where d_author = '").appending(author).appending("'")
        var array = [Poetry]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
        }
        catch{
            print(error)
        }
        
        return array
    }

    public class func getAll()-> [Poetry] {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME)
        var array = [Poetry]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
        }
        catch{
            print(error)
        }
        
        return array
    }

}
