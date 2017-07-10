//
//  PoetryImage.swift
//  shishi
//
//  Created by tb on 2017/7/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

//背景图片
enum PoetryImage: Int {
    case bg001 = 1,
    bg002 = 2,
    bg004 = 4,
    bg006 = 6,
    bg007 = 7,
    bg011 = 11,
    bg013 = 13,
    bg072 = 72,
    bg084 = 84,
    bg096 = 96,
    bg118 = 118
    
    public static let allValues:[PoetryImage] = [.bg001, .bg002, .bg004, .bg006, .bg007, .bg011, .bg013, .bg072, .bg084, .bg096, bg118]
    
    public func imageName() -> String {
        switch self {
        case .bg001:
            return "bg001"
        case .bg002:
            return "bg002"
        case .bg004:
            return "bg004"
        case .bg006:
            return "bg006"
        case .bg007:
            return "bg007"
        case .bg011:
            return "bg011"
        case .bg013:
            return "bg013"
        case .bg072:
            return "bg072"
        case .bg084:
            return "bg084"
        case .bg096:
            return "bg096"
        case .bg118:
            return "bg118"
        
        }
    }
    
    public func image() -> UIImage {
        return UIImage(named: self.imageName())!
    }
}


