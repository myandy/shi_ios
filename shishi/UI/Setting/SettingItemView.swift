//
//  SettingItemView.swift
//  shishi
//
//  Created by andymao on 2017/5/20.
//  Copyright © 2017年 andymao. All rights reserved.
//

import Foundation

class SettingItemView : UIView {
    
    public var title: UILabel!
    public var hint: UILabel!
    
    
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
        
        let rev = UIImageView()
        rev.image = UIImage(named:"next_hl")
        self.addSubview(rev)
        rev.snp.makeConstraints{ (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        
        hint = UILabel()
        hint.textColor = UIColor.white
        self.addSubview(hint)
        hint.snp.makeConstraints{ (make) in
            make.right.equalTo(rev.snp.left)
            make.centerY.equalToSuperview()
        }

        
    }

    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.white
        self.hint.textColor = UIColor.white
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.gray
        self.hint.textColor = UIColor.gray

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.title.textColor = UIColor.white
        self.hint.textColor = UIColor.white
    }
    

    

}
