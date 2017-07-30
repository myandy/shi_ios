//
//  ShareImageCollectionViewCell.swift
//  shishi
//
//  Created by tb on 2017/7/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class ShareImageCollectionViewCell: UICollectionViewCell {
    public var isItemSelected = false
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupUI() {
        self.contentView.clipsToBounds = true
        
        self.setupViews()
        self.setupConstraints()
    }
    
    internal func setupViews() {
        self.contentView.backgroundColor = UIColor(hexColor: "A9A9AB")
        self.contentView.addSubview(self.imageView)
    }
    
    internal func setupConstraints() {
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public func updateSelectedStatus(isSelected: Bool) {
        if self.isItemSelected == isSelected {
            return
        }
        self.isItemSelected = isSelected
        
        let insets = self.isItemSelected ? UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) : UIEdgeInsets.zero
        
        UIView.animate(withDuration: 0.25) { [weak self] () in
            
            self?.imageView.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview().inset(insets)
            }
            self?.contentView.layoutIfNeeded()
        }
        
    }
}
