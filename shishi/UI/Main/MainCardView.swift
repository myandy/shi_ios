//
//  MainCardView.swift
//  shishi
//
//  Created by tb on 2017/5/24.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
import Koloda

class MainCardView: UIView {
    lazy var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.addSubview(kolodaView)
        return kolodaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.kolodaView.snp.makeConstraints { (make) in
            make.width.centerY.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        self.kolodaView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
    }
}

// MARK: - KolodaViewDataSource
extension MainCardView: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return 5
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: UIImage(named: "bg001.jpg"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
    }
}


// MARK: - KolodaViewDelegate
extension MainCardView: KolodaViewDelegate {
    
}
