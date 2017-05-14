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

extension Yun : SearchModel{
    func getTitle() -> String {
        return name!
    }
    
    func getDesc() -> String {
        return String(count!)
    }
}

class YunDB{
    private static let TABLE_NAME="t_yun"
    
    private static let BY_PNUM = " order by id "
    
    public class func getArray(_ rs: FMResultSet)-> [Yun]{
        var array = [Yun]()
        while rs.next() {
            let model = Yun()
            model.id = rs.int(forColumn: "id")
            model.name = rs.string(forColumn: "name")
            model.yun = rs.string(forColumn: "yun")
            model.count = rs.int(forColumn: "count")
            array.append(model)
        }
        return array
    }
    
    public class func getAll()-> [Yun] {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME)
        
        var array = [Yun]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
            
        }
        catch{
        }
        
        return array
        
    }

    
}
