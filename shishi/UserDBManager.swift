//
//  UserDBManager.swift
//  shishi
//
//  Created by tb on 2017/6/11.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class UserDBManager: NSObject {
    
    public static let `default`: UserDBManager = UserDBManager()
    
    public static let dbFileExtension = ".sql"
    
    struct DBName {
        static let user = "user"
    }
    
    override init() {
        super.init()
        DBMigration().migration()
    }
    
    public func configure() {
        
    }
}
