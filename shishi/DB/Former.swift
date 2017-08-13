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
    
    var id: Int64!
    var name: String!
    var source: String!
    var pingze: String!
    var count: Int!
    var type: Int!
}

extension Former : SearchModel {
    func getTitle() -> String {
        return name!
    }
    
    func getDesc() -> String {
        return String(count!)
    }
    
    func getHint()-> String {
        return String(count!)
    }
}


class FormerDB {
    private static let TABLE_NAME="cipai"
    
    private static let BY_PNUM = " order by id resc "
    
    public class func getArray(_ rs: FMResultSet) -> [Former] {
        var array = [Former]()
        while rs.next() {
            let model = Former()
            model.id = Int64(rs.int(forColumn: "id"))
            model.name = rs.string(forColumn: "name")
            model.source = rs.string(forColumn: "source")
            model.pingze = rs.string(forColumn: "pingze")
            model.count = Int(rs.int(forColumn: "wordcount"))
            array.append(model)
        }
        return array
    }
    
    public class func getAll() -> [Former] {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME)
        
        var array = [Former]()
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
    
    public class func getFormer(with formerId: Int64) -> Former? {
        let allFormer = getAll()
        return allFormer.first { (former) -> Bool in
            return former.id == formerId
        }
    }
}
