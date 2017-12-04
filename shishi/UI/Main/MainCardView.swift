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
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        
        
        return label
    }()
    
//    lazy var authorLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textColor = UIColor.white
//        return label
//    }()
    
    lazy fileprivate(set) var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    var contentArray = [Writting]()
    
    lazy var kolodaView: SSKolodaView = {
        let kolodaView = SSKolodaView()
//        kolodaView.backgroundColor = UIColor.white
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        
        
        return kolodaView
    }()
    
    public weak var delegate: MainCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews()
        
        SSNotificationCenter.default.rx.notification(SSNotificationCenter.Names.updateFontSize).subscribe(onNext: { [weak self] notify in
            self?.updateFontSize()
        })
            .addDisposableTo(self.rx_disposeBag)
        
//        SSNotificationCenter.default.rx.notification(SSNotificationCenter.Names.updateAuthorName).subscribe(onNext: { [weak self] notify in
//            self?.updateUserName()
//        })
//            .addDisposableTo(self.rx_disposeBag)
        
        self.updateFontSize()
//        self.updateUserName()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(cipai: String, dateString: String, contentArray: [Writting]) {
        self.cipaiLabel.text = cipai
        self.dateLabel.text = dateString
        
        self.contentArray = contentArray
        
//        self.kolodaView.reloadData()
//        self.setupSubviews()
        self.addKolodaView()
    }
    
//    internal func updateUserName() {
//        let userName = UserDefaultUtils.getUsername()
//        self.authorLabel.text = userName
//    }
    
    private func addKolodaView() {
        self.addSubview(self.kolodaView)
        self.kolodaView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(self.dateLabel.snp.bottom).offset(10)
            make.height.equalTo(self.kolodaView.snp.width)
        }
    }
    
    //更新字体大小
    internal func updateFontSize() {
        let titleFontSize = AppConfig.Constants.titleFontSize + DataContainer.default.fontOffset
        let timeFontSize = AppConfig.Constants.timeFontSize + DataContainer.default.fontOffset
//        let authorFontSize = AppConfig.Constants.writtingAuthorFontSize + DataContainer.default.fontOffset
        self.cipaiLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        self.dateLabel.font = UIFont.systemFont(ofSize: timeFontSize)
//        self.authorLabel.font = UIFont.systemFont(ofSize: authorFontSize)
    }
    
    private func setupSubviews() {
        self.addSubview(self.cipaiLabel)
        self.cipaiLabel.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(convertHeight(pix: 220))
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        })
        
//        self.addSubview(self.authorLabel)
//        self.authorLabel.snp.makeConstraints({ (make) in
//            make.top.equalTo(self.cipaiLabel.snp.bottom).offset(convertWidth(pix:10))
//            make.centerX.equalToSuperview()
//        })
        
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.cipaiLabel.snp.bottom).offset(convertWidth(pix:10))
            make.centerX.equalToSuperview()
        })
        
        
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
//        let cardView = UIView()
        let cardView = MainKolodaView(frame: koloda.bounds)
//        
        
        let writting = self.contentArray[index]
        cardView.setup(writting: writting)

        
//        let label = UILabel(frame: koloda.bounds)
//        cardView.addSubview(label)
//        label.text = writting.text
//        label.snp.makeConstraints { (make) in
//            let inset = convertWidth(pix: 20)
//            make.left.equalToSuperview().offset(inset * 1.5)
//            make.top.equalToSuperview().offset(inset)
//            make.right.equalToSuperview().offset(-inset * 1.5)
//        }
//        label.numberOfLines = 0
        let tapGuesture = UITapGestureRecognizer()
        tapGuesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                //self?.showMenu(index: index)
                self?.onKolodaViewClick(view: cardView, index: index)
            })
            .addDisposableTo(self.rx_disposeBag)
        
        cardView.addGestureRecognizer(tapGuesture)
//
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
