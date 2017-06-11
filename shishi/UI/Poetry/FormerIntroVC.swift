//
//  FormerIntroVC.swift
//  shishi
//
//  Created by andymao on 2017/6/7.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation


class FormerIntroVC : UIViewController {
    
    var introView: UIWebView!
    
    var sourceView: UILabel!
    
    var former: Former
    init(former : Former) {
        self.former = former
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        setupUI()
    }
    
    
    func setupUI(){
        addBackgroundImage()
        
        let backView = UIImageView()
        self.view.addSubview(backView)
        backView.image = UIImage(named:"cancel")
        backView.contentMode = UIViewContentMode.center
        backView.snp.makeConstraints{ (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onBackBtnClicked)))
        
        let titleView = UILabel()
        self.view.addSubview(titleView)
        titleView.text = former.name
        titleView.textColor = UIColor.white
        titleView.font = UIFont.systemFont(ofSize: 34)
        titleView.numberOfLines = 0
        titleView.snp.makeConstraints{ (make) in
            make.width.equalTo(40)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }
        
        introView = UIWebView()
        introView.backgroundColor = UIColor.clear
        introView.isOpaque = false
        self.view.addSubview(introView)
        introView.snp.makeConstraints{ (make) in
            make.right.equalTo(titleView.snp.left).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(titleView.snp.top)
            make.bottom.equalTo(backView.snp.top)
        }
        let path = Bundle.main.path(forResource: "intro", ofType: ".html")
        let urlStr = NSURL.fileURL(withPath: path!)
        introView.loadRequest(URLRequest(url: urlStr))
        
        sourceView = UILabel()
        sourceView.text = former.source
        sourceView.textColor = UIColor.white
        sourceView.font = UIFont.systemFont(ofSize: 16)
        sourceView.numberOfLines = 0
        introView.scrollView.addSubview(sourceView)
        
        
        FontsUtils.setFont(view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let margin:CGFloat = 20.0
        let height = former.source.heightWithConstrainedWidth(width: introView.frame.width, font: sourceView.font)
        introView.scrollView.contentInset = UIEdgeInsets(top: height+margin, left: 0, bottom: 0, right: 0)
        sourceView.frame = CGRect(x: 0, y: -height-margin, width: introView.frame.width, height: height)
    }
    
    func onBackBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
