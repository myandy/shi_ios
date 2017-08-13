//
//  UIButton+SS.swift
//  shishi
//
//  Created by tb on 2017/8/13.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import RxSwift

extension UIButton {
    public func addTapHandler(handle: @escaping () -> Void) {
        self.rx.tap
            .throttle(AppConfig.Constants.TAP_THROTTLE, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                handle()
            })
            .addDisposableTo(self.rx_disposeBag)
    }
}
