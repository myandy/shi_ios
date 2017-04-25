//
//  RandomPoetryViewController.swift
//  shishi
//
//  Created by andymao on 2016/12/24.
//  Copyright © 2016年 andymao. All rights reserved.
//

import UIKit

class RandomPoetryVC: UIViewController {
    
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var lableContent: UILabel!
    @IBOutlet weak var lableTitle: UILabel!
    
    @IBOutlet weak var btnRandom: UIButton!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lableAuthor: UILabel!
    @IBAction func randomClick(_ sender: AnyObject) {
        refresh()
    }
    
    
    @IBAction func cancelClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var poetry:Poetry!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBAction func editClick(_ sender: AnyObject) {
    }
    
    override public func viewDidLoad() {
        refresh()
        FontsUtils.setFont(view: self.view)
        
        
    }
    override func viewDidLayoutSubviews() {
        btnShare.layer.cornerRadius = btnShare.frame.size.width / 2
    }
    
    
    
    func refresh(){
        poetry = PoetryDB.getRandomPoetry()
        
        lableTitle.text=poetry.title
        lableContent.text=poetry.poetry
        
        if (poetry.intro?.characters.count)! > 5{
            introLabel.text=poetry.intro
        }
        else{
            introLabel.text=nil
        }
        
        
        let data = AuthorDB.getAuthor(name: poetry.author!)
        
        let cInt : Int32  = data!.color as Int32!
        let color = UIColor(intColor:Int(cInt))
        btnShare.backgroundColor = color
        lableAuthor.text=poetry.author
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
