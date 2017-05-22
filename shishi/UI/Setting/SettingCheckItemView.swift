//
//  SettingCheckItemView.swift
//  shishi
//
//  Created by andymao on 2017/5/22.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SettingCheckItemView : UIView {
    
    public var title: UILabel!
    
    public var checkView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        title = UILabel()
        title.textColor = UIColor.white
        self.addSubview(title)
        title.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        checkView = UIImageView()
        checkView.image = UIImage(named:"done")
        self.addSubview(checkView)
        checkView.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.white
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.gray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.white
    }

}
