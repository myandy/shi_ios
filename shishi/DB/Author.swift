//
//  Author.swift
//  shishi
//
//  Created by andymao on 2016/12/22.
//  Copyright © 2016年 andymao. All rights reserved.
//

import Foundation
import FMDB

class Author{
    var name:String?
    var enName:String?
    var intro:String?
    var dynasty:String?
    var pNum:Int32?
}

extension Author : SearchModel{
    func getTitle() -> String {
        return name!
    }
    
    func getDesc() -> String {
        return dynasty!.appending(" ● ").appending(String(Int(pNum!)))
    }
}

class AuthorDB{
    
    private static let TABLE_NAME="t_author"
    
    private static let BY_PNUM = " order by p_num"
    
    private static let BY_DNUM = " order by d_num"

    
    private class func getList(rs: FMResultSet)->NSMutableArray?{
        let array = NSMutableArray()
        while rs.next() {
            let model = Author()
            model.intro = rs.string(forColumn: "d_intro")
            model.name = rs.string(forColumn: "d_author")
            model.enName = rs.string(forColumn: "en_name")
             model.dynasty = rs.string(forColumn: "d_dynasty")
            model.pNum = rs.int(forColumn: "p_num")
            array.add(model)
        }
        return array
    }
    
    
    public class func getAuthor(name : String)->Author! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" where d_author like '").appending(name).appending("'")
        var array = NSMutableArray()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getList(rs: rs)!
            
        }
        catch{
        }
        if array.count>0{
            return array[0] as! Author
        }
        return nil
        
    }


    public class func getAll(byPNum:Bool,dynasty:Int)->NSMutableArray! {
    let db = DBManager.shared.getDatabase()
        var sql = "select * from ".appending(TABLE_NAME)
        if dynasty>0{
            sql = sql.appending(" where d_dynasty like '").appending(DBManager.DYNASTYS[dynasty]).appending("'")
        }
        if byPNum{
            sql = sql.appending(BY_PNUM)
        }
        else{
            sql = sql.appending(BY_DNUM)
        }
        var array = NSMutableArray()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getList(rs: rs)!
            
        }
        catch{
        }
        if(array.count % 2 != 0){
//            let data =  Author()
            array.removeObject(at: 0)
        }
        
        return array
        
    }

    
    
   
}
