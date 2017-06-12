//
//  DBMigration.swift
//  shishi
//
//  Created by tb on 2017/6/11.
//  Copyright © 2017年 andymao. All rights reserved.
//

//import FCModel

import FMDB

private let previousVersion: UInt64 = 0

private let dbFileName = "user.db"

private let dbFileExt = ".sql"

class DBMigration: NSObject {

    public func migration() {
//        FCModel.closeDatabase()
        let dbPath = self.dbFilePath
        
        FCModel.openDatabase(atPath: dbPath, withDatabaseInitializer: { (db) in
            log.debug()
        }) { (db, schemaVersion) in
            let value = schemaVersion!.pointee
            if value < 1 {
                self.migrationTo1(db: db!)
                schemaVersion!.pointee = 1
            }
        }
        
    }
    
    func failedAt(db: FMDatabase, statement: Int) {
        let lastErrorCode = db.lastErrorCode
        let lastErrorMessage = db.lastErrorMessage
        db.rollback()
        assert(false, "Migration statement \(statement) failed, code \(lastErrorCode): \(lastErrorMessage)")
    }
    
    private var dbFilePath: String {
        let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (docPath as NSString).appendingPathComponent(dbFileName)
    }
    
    private func migrationTo1(db: FMDatabase) {
        self.migration(db: db, fileName: "user_1")
    }
    
    private func migration(db: FMDatabase, fileName: String) {
        let fullName = fileName + dbFileExt
        let sql = self.sqlString(fileName: fullName)
        self.migration(db: db, sql: sql)
    }
    
    private func sqlString(fileName: String) -> String {
        let bundlePath = (Bundle.main.bundlePath as NSString).appendingPathComponent(fileName)
        log.debug(bundlePath)
        assert(FileManager.default.fileExists(atPath: bundlePath))
        let url = URL(fileURLWithPath: bundlePath)
        let data = try! Data(contentsOf: url)
        let sql = String(data: data, encoding: String.Encoding.utf8)
        return sql!
    }
    
    private func migration(db: FMDatabase, sql: String) {
        do {
            try db.executeUpdate(sql, values: [])
        } catch let error {
            log.warning(error)
            self.failedAt(db: db, statement: 1)
        }
    }
}

