//
//  StringUtils.swift
//  shishi
//
//  Created by andymao on 2017/4/15.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

public class StringUtils {
    
    public static func isPurnInt(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
    public static func getLastChinese(_ string :String) -> Character?{
        for value in string.characters.reversed() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return value
            }
        }
        return nil
    }
    
    
    /// 从字符串中提取数字
    public class func getIntFromString(str:String) -> String {
        let scanner = Scanner(string: str)
        scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        var number :Int = 0
        scanner.scanInt(&number)
        return String(number)
    }
    
    //过滤标题中的注释
    public class func titleTextFilter(poerityTitle: String) -> String {
        let pattern = "\\(.*\\)|（.*）"
        let range = Range(poerityTitle.startIndex..<poerityTitle.endIndex)
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return regex.stringByReplacingMatches(in: poerityTitle, options: [], range: poerityTitle.nsRange(from: range), withTemplate: "")
    }
    
    //过滤内容中的注释
    public class func contentTextFilter(poerityTitle: String) -> String {
        let pattern = "\\[.*\\]|【.*】"
        let range = Range(poerityTitle.startIndex..<poerityTitle.endIndex)
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return regex.stringByReplacingMatches(in: poerityTitle, options: [], range: poerityTitle.nsRange(from: range), withTemplate: "")
    }
}

extension String {
    func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)
        let upper = UTF16View.Index(range.upperBound, within: utf16)
        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower!.distance(to: upper))
    }
}
