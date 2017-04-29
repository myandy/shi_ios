//
//  DataContainer.swift
//  shishi
//
//  Created by tb on 2017/4/29.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class DataContainer: NSObject {
    open static let `default`: DataContainer = {
        return DataContainer()
    }()
    
    
    lazy private(set) var duishiNetwork: DuiShiNetwork = {
        return AppConfig.isStubbingNetwork ? Networking.newDuiShiStubbingNetwork() : Networking.newDuiShiNetwork()
    }()
}
