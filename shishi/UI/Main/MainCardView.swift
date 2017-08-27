//
//  MainCardView.swift
//  shishi
//
//  Created by tb on 2017/5/24.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit
//import Koloda
import FTPopOverMenu_Swift

protocol MainCardViewDelegate: class {
    func mainCard(_ mainCardView: MainCardView, didTapCell cell: UIView, forRowAt index: Int)
    func mainCard(_ mainCardView: MainCardView, didSwipeCardAt index: Int)
}

class MainCardView: UIView {
    
    lazy var cipaiLabel: UILabel = {
       let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(convertHeight(pix: 100))
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        })
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(self.cipaiLabel.snp.bottom).offset(convertWidth(pix:20))
            make.centerX.equalToSuperview()
        })
        return label
    }()
    
    var contentArray = [String]()
    
    lazy var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
//        kolodaView.backgroundColor = UIColor.white
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.addSubview(kolodaView)
        
        
        return kolodaView
    }()
    
    public weak var delegate: MainCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.setupSubviews()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(cipai: String, dateString: String, contentArray: [String]) {
        self.cipaiLabel.text = cipai
        self.dateLabel.text = dateString
        self.contentArray = contentArray
        
        self.setupSubviews()
    }
    
    private func setupSubviews() {
        self.kolodaView.snp.makeConstraints { (make) in
            make.width.bottom.centerX.equalToSuperview()
            make.top.equalTo(self.dateLabel.snp.bottom).offset(20)
        }
    }
    
    fileprivate func onKolodaViewClick(view: UIView, index: Int) {
        if let delegate = self.delegate {
            delegate.mainCard(self, didTapCell: view, forRowAt: index)
        }
    }
    
//    fileprivate func showMenu(index: Int) {
//        var senderFrame = UIScreen.main.bounds
//        senderFrame.origin.y = senderFrame.size.height / 2
//        senderFrame.size.height = senderFrame.size.height / 2
//        FTPopOverMenu.showFromSenderFrame(senderFrame: senderFrame,
//                                    with: [SSStr.Share.SHARE, SSStr.Common.EDIT, SSStr.Common.DELETE],
//                                    done: { [unowned self] (selectedIndex) -> () in
//                                        switch selectedIndex {
////                                        case 0:
//                                            
//                                            
//                                        default:
//                                            break
//                                        }
//        }) {
//            
//        }
//    }
    
//    internal func showShareEditVC() {
//        let shareController = ShareEditVC()
//        shareController.poetry = self.poetry
//        self.navigationController?.pushViewController(shareController, animated: true)
//    }
}

// MARK: - KolodaViewDataSource
extension MainCardView: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return self.contentArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = UIColor.white
        
        let label = UILabel(frame: koloda.bounds)
        cardView.addSubview(label)
        label.text = self.contentArray[index]
        label.snp.makeConstraints { (make) in
            let inset = convertWidth(pix: 20)
            make.left.equalToSuperview().offset(inset * 1.5)
            make.top.equalToSuperview().offset(inset)
            make.right.equalToSuperview().offset(-inset * 1.5)
        }
        label.numberOfLines = 0
        let tapGuesture = UITapGestureRecognizer()
        tapGuesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                //self?.showMenu(index: index)
                self?.onKolodaViewClick(view: cardView, index: index)
            })
            .addDisposableTo(self.rx_disposeBag)
        
        cardView.addGestureRecognizer(tapGuesture)
//        let cardView = MainKolodaView()
//        //cardView.contentTe
//        cardView.backgroundColor = UIColor.red
        return cardView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
    }
}


// MARK: - KolodaViewDelegate
extension MainCardView: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        log.debug()
        if let delegate = self.delegate {
            delegate.mainCard(self, didSwipeCardAt: index)
        }
    }

}
