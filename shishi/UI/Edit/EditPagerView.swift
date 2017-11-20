//
//  EditPagerView.swift
//  shishi
//
//  Created by andymao on 2017/4/23.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit


private let editCellIdentifier = "editCellIdentifier"

private let TOP_HEIGHT = 60

public class EditPagerView : UIView {
    //是否需要保存，如果有编辑才需要保存
    public var hasEdit = false
    
    public var writing: Writting!
    
    //列表
    var tableView: UITableView!
    
    var clist: Array<String>!
    
    //已经输入的内容
    var contentArray: [String?]!
    
    var title: UILabel!
    
    //背景图片
    var defaultImage = PoetryImage.dust
    //顶部背景
    var headView: UIImageView!
    //中间的TABLEVIEW的背景
    var backgroundImageView: UIImageView!
    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupSubviews()
//
//        let image = UIImage(named: EditPagerView.bgimgList[Int(writing.bgImg)]) ?? self.defaultImage.image()
//        self.updateImage(image: image)
//    }
    
    init(writting: Writting) {
        super.init(frame: CGRect.zero)
        self.writing = writting
        let former = writing.former
        let slist = former.pingze.characters.split(separator: "。").map(String.init)
        clist = EditUtils.getCodeFromPingze(list: slist)
        
        self.contentArray = Array.init(repeating: nil, count: clist.count)
        let textArray = writting.text.components(separatedBy: Writting.textSeparator)
        for (index, item) in textArray.enumerated() {
            self.contentArray[index] = item
        }
        
        
        self.setupSubviews()
        
        let poetryImage = PoetryImage(rawValue: Int(writting.bgImg))!
        let image = poetryImage.image()
        self.updateImage(image: image)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupSubviews() {
//        //测试代码
//        if writing == nil{
//            writing = Writting()
//        }
        
        setupHeadView()
        
        self.backgroundImageView = UIImageView()
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(TOP_HEIGHT)
            make.bottom.left.right.equalToSuperview()
        }
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.register(EditPagerCell.self, forCellReuseIdentifier: editCellIdentifier)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(TOP_HEIGHT)
            make.bottom.left.right.equalToSuperview()
        }
//        tableView.bounces = false
    }
    
    
    func setupHeadView(){
        let ivTop = UIImageView()
        self.headView = ivTop
        self.addSubview(ivTop)
        ivTop.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(TOP_HEIGHT)
        }
        ivTop.backgroundColor = UIColor.clear
        ivTop.isUserInteractionEnabled = true
        
        
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
        if writing.title == nil {
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
    
    func updateImage(image: UIImage) {
        self.headView.image = image
        self.backgroundImageView.image = image
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
            self.hasEdit = true
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
    
    //生成输入的内容
    func mergeContent() -> String {
        var content = ""
        for item in self.contentArray {
            if let item = item {
                if !content.isEmpty {
                    content += Writting.textSeparator
                }
                content += item
            }
        }
        return content
    }
}

extension EditPagerView: UITableViewDataSource,UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clist.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editCellIdentifier, for: indexPath) as! EditPagerCell
        let textArray = self.writing.textArray
        let content: String? = textArray.count > indexPath.row ? textArray[indexPath.row] : nil
        cell.refresh(code: clist[indexPath.row], content: content)
        cell.editHandler = { [unowned self] content in
            self.contentArray[indexPath.row] = content
            self.hasEdit = true
        }
        return cell
    }
    
    
}
