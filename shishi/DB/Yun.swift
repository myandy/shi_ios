//
//  Yun.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation
import FMDB

public class Yun {
    
    var tone: Int!
    var glys: String!
    var section_desc: String!
    var tone_name: String!
}


class YunDB {
    private static let YUNSHU = ["zhonghuaxinyun", "pingshuiyun", "cilinzhengyun"]
    
    private static var yunList = [Yun]()
    
    public class func getArray(_ rs: FMResultSet) -> [Yun]{
        var array = [Yun]()
        while rs.next() {
            let model = Yun()
            model.tone = Int(rs.int(forColumn: "tone"))
            model.glys = rs.string(forColumn: "glys")
            model.section_desc = rs.string(forColumn: "section_desc")
            model.tone_name = rs.string(forColumn: "tone_name")
            array.append(model)
        }
        return array
    }
    
    public class func getAll() -> [Yun] {
        let db = DBManager.shared.getDatabase()
        let sql = "select * from ".appending(YUNSHU[UserDefaultUtils.getYunshu()])
        
        var array = [Yun]()
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
    
    private class func getYunList(){
        if yunList.isEmpty{
            yunList = getAll()
        }
    }
    
    /**
     * 获取平仄
     */
    
    public class func getWordStone(_ word: Character) ->Int {
        getYunList()
        var tones=[Int]()
        for item in yunList{
            if (item.glys.characters.contains(word)) {
                tones.append(Int(item.tone))
            }
        }
        if (tones.count == 1) {
            return tones[0];
        } else {
            return 30;
        }
        
    }
    
    /**
     * 获取同韵字
     */
    public class func getSameYun(_ word: Character) -> [Yun] {
        getYunList()
        var yuns=[Yun]()
        for item in yunList{
            if (item.glys.characters.contains(word)) {
                yuns.append(item)
            }
        }
        return yuns
    }
}
