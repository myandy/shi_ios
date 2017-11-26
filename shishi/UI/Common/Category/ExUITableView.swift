//
//  ExUITableView.swift
//  shishi
//
//  Created by tb on 2017/11/26.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit


extension UITableView {
    //隐藏多余的单元格，不显示分割线
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
