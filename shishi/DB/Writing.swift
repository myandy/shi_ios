//
//  Writing.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

import FMDB

public class Writing {
    
    var id: Int!
    var text: String!
    var formerId:Int!
    var title: String!
    var create_dt: CLong!
    var update_dt: CLong!
    var bgimg = 0
    var author: String!
    var former: Former!
    
}

public class WritingDB{
    static let TABLE_NAME = "writing"
    
    static let ORDER_BY = " order by update_dt"
    
    public class func getArray(_ rs: FMResultSet)-> [Writing]{
        var array = [Writing]()
        while rs.next() {
            let model = Writing()
            model.id = Int(rs.int(forColumn: "id"))
            model.text = rs.string(forColumn: "text")
            model.formerId = Int(rs.int(forColumn: "former_id"))
            model.title = rs.string(forColumn: "title")
            model.create_dt = rs.long(forColumn: "create_dt")
            model.update_dt = rs.long(forColumn: "update_dt")
            model.bgimg = Int(rs.int(forColumn: "bgimg"))
            model.author = rs.string(forColumn: "author")
            array.append(model)
        }
        return array
    }
    
    
    public class func getAll()-> [Writing] {
        let db = DBManager.shared.getDatabase()
        var sql = "select * from ".appending(TABLE_NAME)
        
        sql = sql.appending(ORDER_BY)
        
        var array = [Writing]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
            
        }
        catch{
        }
        
        return array
    }
    
    public class func addWriting(writing: Writing) {
        let db = DBManager.shared.getDatabase()
        var sql = "insert into ".appending(TABLE_NAME)
        
        sql = sql.appending("(id,text,former_id,title,create_dt,update_dt,bgimg,author) values (?,?,?,?,?,?,?,?)")
        
        let date = NSDate().timeIntervalSince1970
        do {
            try  db.executeUpdate(sql,values: [writing.id,writing.text,writing.formerId,writing.title,date,date,writing.bgimg,writing.author])
        }
        catch{
        }
        
    }
    
    
    
    public class func  deleteWriting(writing: Writing) {
        let db = DBManager.shared.getDatabase()
        let sql = "delete from ".appending(TABLE_NAME).appending(" where id = ?" )
        
        do {
            try db.executeUpdate(sql,values:[writing.id])
        }
        catch{
        }
    }
    
    
}
