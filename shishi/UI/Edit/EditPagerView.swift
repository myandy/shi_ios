//
//  EditPagerView.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation


private let editCellIdentifier = "editCellIdentifier"

private let TOP_HEIGHT = 60

public class EditPagerView : UIView{
    
    
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
    
    //列表
    var tableView: UITableView!
    
    var clist:Array<String>!
    
    public override func draw(_ rect: CGRect) {
        
        //测试代码
        if writing == nil{
            writing = Writing()
        }
        
        setupHeadView()
        
        
        
        let backgroundImage=UIImageView()
            backgroundImage.image=UIImage(named: EditPagerView.bgimgList[Int(writing.bgimg)])
        self.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(TOP_HEIGHT)
            make.bottom.left.right.equalToSuperview()
        }
        
        
        let former = writing.former
        let slist = former!.pingze.characters.split(separator: "。").map(String.init)
        clist = EditUtils.getCodeFromPingze(list: slist)
        
        //        let srcollView = UIScrollView()
        //        srcollView.showsVerticalScrollIndicator=true
        //        srcollView.isScrollEnabled = true // 可以上下滚动
        //        srcollView.scrollsToTop = true // 点击状态栏时，可以滚动回顶端
        //        srcollView.bounces = true // 反弹效果，即在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        //        srcollView.contentSize = CGSize(width:srcollView.bounds.width,height: 100)
        //        self.addSubview(srcollView)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.register(EditPagerCell.self, forCellReuseIdentifier: editCellIdentifier)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(TOP_HEIGHT)
            make.bottom.left.right.equalToSuperview()
        }
        
        //        self.tableView.reloadData()
        
        //        var lastItemBottom:CGFloat = 0
        //        for i in 0...clist.count-1{
        //            let itemTop: CGFloat = CGFloat(70*i+10)
        //            let frame = CGRect(x:10,y: itemTop, width:self.bounds.width - 10,height:20)
        //            let linearView = PingzeLinearView(frame: frame, code: clist[i].trimmingCharacters(in:NSCharacterSet.newlines))
        //            srcollView.addSubview(linearView)
        //            let frame1 = CGRect(x:10,y:itemTop+30,width:self.bounds.width - 10, height:20)
        //            let textField=UITextField(frame:frame1)
        //            textField.textColor=UIColor.lightGray
        //            textField.tintColor=UIColor.lightGray
        //            srcollView.addSubview(textField)
        //
        //            let lineView = UIView(frame:CGRect(x:10,y:itemTop+49,width:self.bounds.width - 10,height:1))
        //            lineView.backgroundColor = UIColor.lightGray
        //            srcollView.addSubview(lineView)
        //
        //            lastItemBottom = itemTop + 49 + 1
        //        }
        
        
        
        //        srcollView.snp.makeConstraints { (make) in
        //            make.top.equalTo( self.ivTop.snp.bottom)
        //            make.bottom.equalTo(self)
        //            make.left.equalTo(self)
        //            make.right.equalTo(self)
        //            make.height.equalTo(lastItemBottom)
        //        }
        
    }
    
    func setupHeadView(){
        let ivTop = UIImageView()
        self.addSubview(ivTop)
        ivTop.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(TOP_HEIGHT)
        }
        ivTop.backgroundColor=UIColor.clear
        ivTop.isUserInteractionEnabled = true
        ivTop.image = UIImage(named: EditPagerView.bgimgList[writing.bgimg])
        
        let keyboard = UIImageView()
        ivTop.addSubview(keyboard)
        keyboard.image = UIImage(named:"keyboard")
        keyboard.contentMode = UIViewContentMode.center
        keyboard.snp.makeConstraints{ (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        let title = UILabel()
        title.text = "标题"
        self.addSubview(title)
        title.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.height.equalTo(60)
            make.left.right.equalTo(keyboard.snp.right)
        }
        
        let info = UIImageView()
        ivTop.addSubview(info)
        info.image = UIImage(named:"info")
        info.contentMode = UIViewContentMode.center
        info.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.right.equalToSuperview().offset(-60)
        }
        
        let dict = UIImageView()
        ivTop.addSubview(dict)
        dict.image = UIImage(named:"dict")
        dict.contentMode = UIViewContentMode.center
        dict.snp.makeConstraints{ (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        keyboard.isUserInteractionEnabled = true
        keyboard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.keyboardClick)))
        
        info.isUserInteractionEnabled = true
        info.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.infoClick)))
        
        dict.isUserInteractionEnabled = true
        dict.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dictClick)))
    }
    
    func keyboardClick(){
        self.endEditing(true)
    }
    
    func infoClick(){
        firstViewController()?.navigationController?.pushViewController(SearchYunVC(), animated: true)
    }
    
    func dictClick(){
        firstViewController()?.navigationController?.pushViewController(SearchYunVC(), animated: true)
    }
    
}

extension EditPagerView: UITableViewDataSource,UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clist.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editCellIdentifier, for: indexPath) as! EditPagerCell
        cell.pingzeLinearView.refresh(code: clist[indexPath.row])
        return cell
    }
    
    
}
