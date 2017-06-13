//
//  EditUtils.swift
//  shishi
//
//  Created by andymao on 2017/5/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class EditUtils {
    
    public static func getCodeFromPingze(list:Array<String>)->Array<String>{
        if(list.count==0){
            return list
        }
        var size=list.count
        if(list[size-1].trimmingCharacters(in:NSCharacterSet.newlines).isEmpty){
            size -= 1
        }
        var codes=Array<String>(repeating: "", count: size)
        for i in 0...size-1 {
            let item = list[i].trimmingCharacters(in:NSCharacterSet.newlines)
            codes[i]=""
            for j in 0...item.characters.count-1{
                let index = item.index(item.startIndex, offsetBy: j)
                let c = item[index]
                if (c == "平") {
                    codes[i] += "1"
                } else if (c == "中") {
                    codes[i] += "2"
                } else if (c == "仄") {
                    codes[i] += "3"
                } else if (c == "（") {
                    
                    let index1 = item.index(item.startIndex, offsetBy: j+1)
                    let index2 = item.index(item.startIndex, offsetBy: j+2)
                    
                    let codeEndIndex=codes[i].index(before: codes[i].endIndex)
                    
                    
                    if(list[i][index1] == "韵" && list[i][index2] == "）"){
                        let value=codes[i][codeEndIndex]
                        let newValue=Int(String(value))!+3
                        codes[i].remove(at: codeEndIndex)
                        codes[i].append(String(newValue))
                    }
                    else if( item[index1] == "增" && item[index2] == "韵"){
                        let value=codes[i][codeEndIndex]
                        let newValue=Int(String(value))!+6
                        codes[i].remove(at: codeEndIndex)
                        codes[i].append(String(newValue))
                    }
                    
                } else if (c == "韵"
                    || c == "增"
                    || c == "）") {
                    
                } else {
                    codes[i].append(c)
                }
            }
        }
        return codes
    }
    
}