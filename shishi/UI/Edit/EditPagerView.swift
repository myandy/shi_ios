//
//  EditPagerView.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation


public class EditPagerView : UIView,Nibloadable{
    
    
    
    @IBOutlet weak var ivTop: UIImageView!
    @IBOutlet weak var keyboard: UIImageView!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var dict: UIImageView!
    
    public static let bgimgList=["dust", "bg001",
                                 "bg002", "bg004", "bg006",
                                 "bg007", "bg011", "bg013",
                                 "bg072", "bg084", "bg096",
                                 "bg118"]
    
    
    public static let bgSmallimgList = ["dust",
                                        "bg001_small" ,"bg002_small",
                                        "bg004_small", "bg006_small",
                                        "bg007_small", "bg011_small",
                                        "bg013_small", "bg072_small",
                                        "bg084_small", "bg096_small",
                                        "bg118_small"]
    
    public var writing: Writing!
    
    
    public override func draw(_ rect: CGRect) {
        
        //测试代码
        if writing == nil{
            writing = Writing()
        }
        
        if Utils.isPurnInt(string:(writing.bgimg)){
            ivTop.image=UIImage(named: EditPagerView.bgimgList[Int(writing.bgimg)!])
        }
        
        let backgroundImage=UIImageView()
        if Utils.isPurnInt(string:(writing?.bgimg)!){
            backgroundImage.image=UIImage(named: EditPagerView.bgimgList[Int(writing.bgimg)!])
        }
        self.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalTo( self.ivTop.snp.bottom).offset(-2)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }

        
        let former = writing.former
        let slist = former!.pingze.characters.split(separator: "。").map(String.init)
        let clist = getCodeFrompingze(list: slist)
        
        let srcollView = UIScrollView()
        srcollView.showsVerticalScrollIndicator=true
        srcollView.isScrollEnabled = true // 可以上下滚动
        srcollView.scrollsToTop = true // 点击状态栏时，可以滚动回顶端
        srcollView.bounces = true // 反弹效果，即在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        srcollView.contentSize = CGSize(width:srcollView.bounds.width,height: 100)
        self.addSubview(srcollView)
        
        
        var lastItemBottom:CGFloat = 0
        for i in 0...clist.count-1{
            let itemTop: CGFloat = CGFloat(70*i+10)
            let frame = CGRect(x:10,y: itemTop, width:self.bounds.width - 10,height:20)
            let linearView = PingzeLinearView(frame: frame, code: clist[i].trimmingCharacters(in:NSCharacterSet.newlines))
            srcollView.addSubview(linearView)
            let frame1 = CGRect(x:10,y:itemTop+30,width:self.bounds.width - 10, height:20)
            let textField=UITextField(frame:frame1)
            textField.textColor=UIColor.lightGray
            textField.tintColor=UIColor.lightGray
            srcollView.addSubview(textField)
            
            let lineView = UIView(frame:CGRect(x:10,y:itemTop+49,width:self.bounds.width - 10,height:1))
            lineView.backgroundColor = UIColor.lightGray
            srcollView.addSubview(lineView)
            
            lastItemBottom = itemTop + 49 + 1
        }
        
        keyboard.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.keyboardClick(_:)))
        keyboard.addGestureRecognizer(tapGes)
        
        srcollView.snp.makeConstraints { (make) in
            make.top.equalTo( self.ivTop.snp.bottom)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(lastItemBottom)
        }
        
    }
    
    func keyboardClick(_ sender: Any){
        self.endEditing(true)
    }
    
    func getCodeFrompingze(list:Array<String>)->Array<String>{
        if(list.count==0){
            return list
        }
        var size=list.count
        if(list[size-1].trimmingCharacters(in:NSCharacterSet.newlines).isEmpty){
            size -= 1
        }
        var codes=Array<String>(repeating: "", count: size)
        for i in 0...size-1{
            codes[i]=""
            for j in 0...list[i].characters.count-1{
                let index = list[i].index(list[i].startIndex, offsetBy: j)
                let c = list[i][index]
                if (c == "平") {
                    codes[i] += "1"
                } else if (c == "中") {
                    codes[i] += "2"
                } else if (c == "仄") {
                    codes[i] += "3"
                } else if (c == "（") {
                    
                    let index1 = list[i].index(list[i].startIndex, offsetBy: j+1)
                    let index2 = list[i].index(list[i].startIndex, offsetBy: j+2)
                    
                    let codeEndIndex=codes[i].index(before: codes[i].endIndex)
                    
                    
                    if(list[i][index1] == "韵" && list[i][index2] == "）"){
                        let value=codes[i][codeEndIndex]
                        let newValue=Int(String(value))!+3
                        codes[i].remove(at: codeEndIndex)
                        codes[i].append(String(newValue))
                    }
                    else if( list[i][index1] == "增" && list[i][index2] == "韵"){
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
