//
//  Color.swift
//  shishi
//
//  Created by andymao on 2017/4/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation


import FMDB

public class Color{
    
    
    var name:String?
    var red:Int32?
    var green:Int32?
    var blue:Int32?
    
}

public class ColorDB{
    
    static let TABLE_NAME="color"
    
    static let BY_PNUM = " order by desc"
    
    public class func getList(rs: FMResultSet)->NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Color()
            model.name = rs.string(forColumn: "name")
            model.red = rs.int(forColumn: "red")
            model.green = rs.int(forColumn: "green")
            model.blue = rs.int(forColumn: "blue")
            array.add(model)
        }
        return array
    }
    
    public class func getAll()->NSMutableArray! {
        let db = DBManager.shared.getDatabase()
        var sql = "select * from ".appending(TABLE_NAME)
        
        sql = sql.appending(BY_PNUM)
        
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
