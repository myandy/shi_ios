//
//  TouchEffectLabel.swift
//  shishi
//
//  Created by andymao on 2017/6/14.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit


class TouchEffectLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textColor = UIColor.white
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textColor = UIColor.gray
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textColor = UIColor.white

    }
    
    
}
