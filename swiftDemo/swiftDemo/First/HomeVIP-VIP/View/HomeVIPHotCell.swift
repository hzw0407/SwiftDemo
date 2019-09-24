//
//  HomeVIPHotCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//  --热播

import UIKit

class HomeVIPHotCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(150)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp_left).offset(0)
            make.right.equalTo(self.imageView.snp_right).offset(0)
            make.top.equalTo(self.imageView.snp_bottom).offset(0)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refreshWithModel(model: CategoryDetailModel) {
        self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
        self.titleLabel.text = model.title
    }
    
}
