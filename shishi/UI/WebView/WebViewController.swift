//
//  WebViewController.swift
//  shishi
//
//  Created by tb on 2017/8/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    public var path: String!
    
    fileprivate let baikeUrl = "http://wapbaike.baidu.com/search?submit=%E8%BF%9B%E5%85%A5%E8%AF%8D%E6%9D%A1&uid=bk_1345472299_718&ssid=&st=1&bd_page_type=1&bk_fr=srch"

    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.loadURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setupUI() {
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func loadURL() {
        self.webView.load(URLRequest(url: self.fullURL()))
    }

    fileprivate func fullURL() -> URL {
        let queryItems = [URLQueryItem(name: "word", value: self.path)]
        let urlComps = NSURLComponents(string: self.baikeUrl)!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
}

extension String {
    
//将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
