//
//  SSKolodaView.swift
//  shishi
//
//  Created by tb on 2017/11/16.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class SSKolodaView: KolodaView {

    // MARK: Frames
    open override func frameForCard(at index: Int) -> CGRect {
        
        var frame = super.frameForCard(at: index)
        frame.origin.y = frame.origin.x
        return frame
    }

}
