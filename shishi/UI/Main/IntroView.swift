//
//  IntroView.swift
//  shishi
//
//  Created by tb on 2017/9/24.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class IntroView: UIView {
    
    lazy var contentArray: [String] = []
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = SSStr.Main.INTRO
        return label
    }()
    
    lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.text = SSStr.Main.GUIDE
        return label
    }()

    lazy var kolodaView: SSKolodaView = {
        let kolodaView = SSKolodaView()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        return kolodaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _ = self.appendData()
        self.setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(convertHeight(pix: 200))
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        })
        
        self.addSubview(self.introLabel)
        self.introLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(convertWidth(pix: 10))
            maker.centerX.equalToSuperview()
        }
        
        self.addSubview(kolodaView)
        
        let introRatio: CGFloat = CGFloat(500) / 600
        self.kolodaView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(self.introLabel.snp.bottom).offset(10)
            make.height.equalTo(self.kolodaView.snp.width).dividedBy(introRatio)
        }
    }
    
    fileprivate func appendData() -> Int {
        let data = ["intro1", "intro2", "intro3", "intro4", "intro5"]
        self.contentArray.append(contentsOf: data)
        return data.count
    }
}



// MARK: - KolodaViewDataSource
extension IntroView : KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return self.contentArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView = UIImageView()
        let imageName = self.contentArray[index]
        cardView.image = UIImage(named: imageName)
        cardView.isUserInteractionEnabled = true
        return cardView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
    }
}

// MARK: - KolodaViewDelegate
extension IntroView: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
//        log.debug(self.contentArray)
//        
////        self.contentArray.append(self.contentArray.remove(at: 0))
//        log.debug(self.contentArray)
//        let lastItem = self.contentArray.count
//        let range: CountableRange<Int> = lastItem..<lastItem
//        koloda.insertCardAtIndexRange(range, animated: true)
        
    }
    
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        let count = self.appendData()
        kolodaView.insertCardAtIndexRange(position..<position + count, animated: true)
    }
}

