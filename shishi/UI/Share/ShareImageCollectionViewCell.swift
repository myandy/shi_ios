//
//  ShareImageCollectionViewCell.swift
//  shishi
//
//  Created by tb on 2017/7/9.
//  Copyright © 2017年 andymao. All rights reserved.
//

import UIKit

class ShareImageCollectionViewCell: UICollectionViewCell {
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
        self.setupViews()
        self.setupConstraints()
    }
    
    internal func setupViews() {
        self.contentView.addSubview(self.imageView)
    }
    
    internal func setupConstraints() {
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
