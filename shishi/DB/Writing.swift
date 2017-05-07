//
//  Writing.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

import FMDB

public class Writing{
    
    var id:Int32?
    var text:String?
    var formerId:Int32?
    var title:String?
    var create_dt:Int32?
    var update_dt:Int32?
    var bgimg="0"
    var author:String?
    var former:Former?
    
}

public class WritingDB{
    static let TABLE_NAME="writing"
    
    static let BY_PNUM = " order by update_dt"
    
    public class func getList(rs: FMResultSet)->NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Writing()
            model.id = rs.int(forColumn: "id")
            model.text = rs.string(forColumn: "text")
            model.formerId = rs.int(forColumn: "former_id")
            model.title = rs.string(forColumn: "title")
            model.create_dt = rs.int(forColumn: "create_dt")
            model.bgimg = rs.string(forColumn: "bgimg")
            model.author = rs.string(forColumn: "author")
            array.add(model)
        }
        return array
    }
    
}
