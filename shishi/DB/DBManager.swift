//
//  DB.swift
//  shishi
//
//  Created by andymao on 2016/12/18.
//  Copyright © 2016年 andymao. All rights reserved.
//

import Foundation
import UIKit
import FMDB

public class DBManager: NSObject {
    
    static let DYNASTYS = ["全部朝代","先秦","汉朝","魏晋","南北朝","唐朝","北宋","南宋","元朝","明朝","清朝","近代","当代"]
    

    //创建单例对象
    public static let shared: DBManager = DBManager()
    
    //数据库文件名，这并不是一定要作为属性，但是方便重用。
    let databaseFileName = "shishi.db"
    //数据库文件的路径
    var pathToDatabase: String!
    //FMDatabase对象用于访问和操作实际的数据库
    var database: FMDatabase!
    
    let dbPath = NSHomeDirectory() + "/Documents/shishi.db"
    
    override init() {
        super.init()
        //创建数据库文件路径
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        pathToDatabase = documentDirectory.appending("/\(databaseFileName)")
    }
    //这里添加后续代码
    //打开数据库
    public func openDatabase() -> Bool{
        //确认database对象是否被初始化，如果为nil，那么判断路径是否存在并创建
        if database == nil{
            if FileManager.default.fileExists(atPath: dbPath){
                database = FMDatabase(path: dbPath)
                NSLog("open from file ")
            }
        }
        //如果database对象存在，打开数据库，返回真，表示打开成功，否则数据库文件不存在或者发生了其它错误
        if database != nil{
            if database.open(){
                NSLog("Success")
                return true
            }
        }
        return false
    }
    
    public func getDatabase()-> FMDatabase{
        return database
    }
    
//    ///查找一条数据
//    func selectModel()->NSMutableArray? {
//        openDatabase()
//        let sql = "SELECT * FROM t_poetry"
//        let array = NSMutableArray()
//        let rs : FMResultSet
//        do {
//          try rs = database!.executeQuery(sql,values: [])
//            while rs.next() {
//                let model = Poetry()
//                model.poetry = rs.string(forColumn: "d_poetry")
//                model.title = rs.string(forColumn: "d_title")
//                model.intro = rs.string(forColumn: "d_intro")
//                model.author = rs.string(forColumn: "d_author")
//                
//                array.add(model)
//            }
//        }
//        catch{
//            
//        }
//
//        database?.close()
//        return array
//      
//    }
    
   
    


    
    
    
}
