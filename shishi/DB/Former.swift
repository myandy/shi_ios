//
//  Former.swift
//  shishi
//
//  Created by andymao on 2017/5/7.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import FMDB
class Former {
    
    var id:Int32?
    var name:String?
    var source:String?
    var pingze:String?
    var count:Int32?
    var type:Int32?
}

extension Former : SearchModel{
    func getTitle() -> String {
        return name!
    }
    
    func getDesc() -> String {
        return String(count!)
    }
}


class FormerDB{
    private static let TABLE_NAME="cipai"
    
    private static let BY_PNUM = " order by id resc "
    
    public class func getList(rs: FMResultSet)->NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Former()
            model.id = rs.int(forColumn: "id")
            model.name = rs.string(forColumn: "name")
            model.source = rs.string(forColumn: "source")
            model.pingze = rs.string(forColumn: "pingze")
            model.count = rs.int(forColumn: "wordcount")
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
