//
//  SSControllerHelper.swift
//  shishi
//
//  Created by tb on 2017/8/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSControllerHelper: NSObject {
    static fileprivate let baikeUrl = "http://wapbaike.baidu.com/search?submit=%E8%BF%9B%E5%85%A5%E8%AF%8D%E6%9D%A1&uid=bk_1345472299_718&ssid=&st=1&bd_page_type=1&bk_fr=srch"
    
    static func fullBaikeUrl(word: String) -> URL {
        let queryItems = [URLQueryItem(name: "word", value: word)]
        let urlComps = NSURLComponents(string: baikeUrl)!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    //作者百科
//    static func showAuthorBaikeContoller(controller: UIViewController, author: String) {
//        let webViewController = WebViewController()
//        webViewController.path = author
//        controller.navigationController?.pushViewController(webViewController, animated: true)
//    }
    static func showBaikeContoller(controller: UIViewController, word: String) {
        let url = fullBaikeUrl(word: word)
        showSynstemWebView(url: url)
    }
    //系统打开链接
    static func showSynstemWebView(url: URL) {
        //根据iOS系统版本，分别处理
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
            })
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //目录界面
    static func showDirectoryContoller(controller: UIViewController, author: String) {
        let searchController = SearchPoetryVC()
        searchController.author = author
        controller.navigationController?.pushViewController(searchController, animated: true)
    }
    
    //分享第二个界面
    static func showShareContoller(controller: UIViewController, poetryTitle: String, poetryAuthor: String, poetryContent: String, bgImage: UIImage?) {
        let shareController = ShareVC()
        //shareController.poetry = self.poetry
        shareController.poetryTitle = poetryTitle
        shareController.poetryAuthor = poetryAuthor
        shareController.poetryContent = poetryContent
        shareController.bgImage = bgImage
        controller.navigationController?.pushViewController(shareController, animated: true)
    }
}
