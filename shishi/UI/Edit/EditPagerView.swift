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
    
    var clist: Array<String>!
    
    var title: UILabel!
    
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
        
        let dict = UIImageView()
        ivTop.addSubview(dict)
        dict.image = UIImage(named:"dict")
        dict.contentMode = UIViewContentMode.center
        dict.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(45)
        }
        
        let info = UIImageView()
        ivTop.addSubview(info)
        info.image = UIImage(named:"info")
        info.contentMode = UIViewContentMode.center
        info.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(45)
            make.right.equalTo(dict.snp.left)
        }
        
        
        title = UILabel()
        if writing.title==nil {
            writing.title = writing.former.name
        }
        title.textColor = UIColor.black
        title.text = writing.title
        ivTop.addSubview(title)
        title.snp.makeConstraints{ (make) in
            make.width.greaterThanOrEqualTo(100)
            make.right.equalTo(info.snp.left)
            make.top.height.equalToSuperview()
            make.left.equalTo(keyboard.snp.right)
        }
        
        keyboard.isUserInteractionEnabled = true
        keyboard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.keyboardClick)))
        
        info.isUserInteractionEnabled = true
        info.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.infoClick)))
        
        dict.isUserInteractionEnabled = true
        dict.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dictClick)))
        
        title.isUserInteractionEnabled = true
        title.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.titleClick)))
        
        FontsUtils.setFont(title)
    }
    
    func titleClick(){
        let alert = UIAlertController(title: SSStr.Edit.INPUT_TITLE, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
            textField.text = self.writing.title
            textField.placeholder = SSStr.Edit.INPUT_TITLE
        }
        let alertView1 = UIAlertAction(title: SSStr.Common.CANCEL, style: UIAlertActionStyle.cancel)
        let alertView2 = UIAlertAction(title: SSStr.Common.CONFIRM, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            self.writing.title = (alert.textFields?.first?.text)!
            self.refreshTitle()
        }
        alert.addAction(alertView1)
        alert.addAction(alertView2)
        
        firstViewController()?.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func refreshTitle(){
        title.text = writing.title
    }
    
    func keyboardClick(){
        self.endEditing(true)
    }
    
    func infoClick(){
        firstViewController()?.navigationController?.pushViewController(FormerIntroVC(former:writing.former), animated: true)
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
        cell.refresh(code: clist[indexPath.row])
        return cell
    }
    
    
}
