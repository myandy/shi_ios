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
    
    /**
     * 1验证成功 0验证失败 2 多音
     *
     * @param hanzi
     * @param code
     * @return
     */
    public static func checkPingze(_ word: Character,code: Character) -> Int{
        var intCode = Int(String(code))!
        while intCode > 3 {
            intCode -= 3
        }
        if (intCode == 1 || intCode == 3) {
            let charCode = YunDB.getWordStone(word)
            
            if charCode == 30 {
                return 2
            } else if (charCode == 10 && intCode == 1) {
                return 1
            } else if (charCode == 20 && intCode == 3) {
                return 1
            } else {
                return 0
            }
        } else {
            return 1
        }
    }
    
    public static func checkTextFiled(textFiled: UITextField,code: String) {
        let code = StringUtils.getIntFromString(str: code)
        var pos = -1
        let text = textFiled.text!
        let attributedString = NSMutableAttributedString(string: text)
        
        for (index,value) in text.characters.enumerated() {
            if pos >= code.characters.count-1 {
                break
            }
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                pos += 1
                let codeIndex = code.index(code.startIndex, offsetBy: pos)
                let checkCode = checkPingze(value,code: code[codeIndex])
                
                if checkCode == 0 {
                    let myRange = NSRange(location: index, length: 1)
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: myRange)
                }
                else if checkCode == 2 {
                    let myRange = NSRange(location: index, length: 1)
                    attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: myRange)
                    
                }
                
            }
            
        }
        
        textFiled.attributedText = attributedString
    }
    
}
