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
    var name: String!
    var enName: String!
    var intro: String!
    var dynasty: String!
    var pNum: Int32!
}

extension Author : SearchModel {
    func getTitle() -> String {
        return name!
    }
    
    func getDesc() -> String {
        return ""
    }
    
    func getHint() -> String {
        return dynasty!.appending(" · ").appending(String(Int(pNum!)))
    }
}

class AuthorDB{
    
    private static let TABLE_NAME = "t_author"
    
    private static let BY_PNUM = " order by p_num"
    
    private static let BY_DNUM = " order by d_num"

    private class func getArray(_ rs: FMResultSet) -> [Author] {
        var array = [Author]()
        while rs.next() {
            let model = Author()
            model.intro = rs.string(forColumn: "d_intro")
            model.name = rs.string(forColumn: "d_author")
            model.enName = rs.string(forColumn: "en_name")
             model.dynasty = rs.string(forColumn: "d_dynasty")
            model.pNum = rs.int(forColumn: "p_num")
            array.append(model)
        }
        return array
    }
    
    public class func getAuthor(name: String) -> Author! {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(TABLE_NAME).appending (" where d_author like '").appending(name).appending("'")
        var array = [Author]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
            
        }
        catch{
        }
        if array.count > 0{
            return array[0]
        }
        return nil
    }

    public class func getAll(byPNum: Bool,dynasty: Int) -> [Author] {
       let db = DBManager.shared.getDatabase()
        var sql = "select * from ".appending(TABLE_NAME)
        if dynasty>0{
            sql = sql.appending(" where d_dynasty like '").appending(SSStr.All.DYNASTIES[dynasty]).appending("'")
        }
        if byPNum{
            sql = sql.appending(BY_PNUM)
        }
        else{
            sql = sql.appending(BY_DNUM)
        }
        var array = [Author]()
        let rs : FMResultSet
        do {
            try rs = db.executeQuery(sql,values: [])
            array = getArray(rs)
            
        }
        catch{
        }
        if(array.count % 2 != 0){
            array.remove(at: 0)
        }
        return array
    }

}
