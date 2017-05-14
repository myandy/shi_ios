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
    
    
    var name:String!
    var red:Int32!
    var green:Int32!
    var blue:Int32!
    
}

extension Color{
    func toUIColor()->UIColor{
        return UIColor(red: CGFloat(red!)/255.0, green: CGFloat(green!)/255.0, blue: CGFloat(blue!)/255.0, alpha: 1.0)
    }
}

public class ColorDB{
    
    static let TABLE_NAME="color"
    
    static let BY_IDX = " where displayidx > 101  order by displayidx desc"
    
    public class func getArray(_ rs: FMResultSet)-> [Color] {
        var array = [Color]()
        while rs.next() {
            let model = Color()
            model.name = rs.string(forColumn: "name")
            model.red = rs.int(forColumn: "red")
            model.green = rs.int(forColumn: "green")
            model.blue = rs.int(forColumn: "blue")
            array.append(model)
        }
        return array
    }
    
    public class func getAll()-> [Color] {
        let db = DBManager.shared.getDatabase()
        var sql = "select * from ".appending(TABLE_NAME)
        
        sql = sql.appending(BY_IDX)
        
        var array = [Color]()
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
