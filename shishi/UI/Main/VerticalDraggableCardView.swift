//
//  VerticalDraggableCardView.swift
//  shishi
//
//  Created by tb on 2017/5/30.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class VerticalDraggableCardView: DraggableCardView {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGesture.translation(in: self)
            return fabs(translation.x) < fabs(translation.y)
        }
        return true
    }
}
