//
//  Yun.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import FMDB

public class Yun{
    
    var id:Int32?
    var name:String?
    var yun:String?
    var count:Int32?
}

public class YunDB{
    static let TABLE_NAME="t_yun"
    
    static let BY_PNUM = " order by id "
    
    public class func getList(rs: FMResultSet)->NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Yun()
            model.id = rs.int(forColumn: "id")
            model.name = rs.string(forColumn: "name")
            model.yun = rs.string(forColumn: "yun")
            model.count = rs.int(forColumn: "count")
            array.add(model)
        }
        return array
    }
    
    public class func getAll()->NSMutableArray! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME)
        
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
