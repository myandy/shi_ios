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
    
    
    lazy private(set) var duiShiNetwork: DuishiNetwork = {
        return AppConfig.isStubbingNetwork ? Networking.newDuishiStubbingNetwork() : Networking.newDuishiNetwork()
    }()
    
    //字体变化每次步径
    private let increaseFontStep: CGFloat = AppConfig.Constants.increaseFontStep
    //调整字体大小
    public var fontOffset: CGFloat = 0
    
    
    override init() {
        self.fontOffset = CGFloat(SSUserDefaults.standard.float(forKey: SSUserDefaults.Keys.fontOffset))
    }
    
    
    
    //增加字体大小
    public func increaseFontOffset() -> CGFloat {
        return self.updateFontOffset(pointSizeStep: increaseFontStep)
    }
    //减少字体大小
    public func reduceFontOffset() -> CGFloat {
        return self.updateFontOffset(pointSizeStep: -increaseFontStep)
    }
    
    public func updateFontOffset(pointSizeStep: CGFloat) -> CGFloat {
        let newFontSize = self.fontOffset + pointSizeStep
        self.fontOffset = newFontSize
        self.saveFontOffset()
        return newFontSize
    }
    
    fileprivate func saveFontOffset() {
        SSUserDefaults.standard.set(self.fontOffset, forKey: SSUserDefaults.Keys.fontOffset)
        SSUserDefaults.standard.synchronize()
    }
    
    
    
}
