//
//  HomeVIPGuessLikeCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//  --猜你喜欢

import UIKit

class HomeVIPGuessLikeCell: UICollectionViewCell {
    
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
    
    lazy var happyLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var freeLabel: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = UIColor.init(red: 203/255.0, green: 148/255.0, blue: 95/255.0, alpha: 1)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp_left).offset(0)
            make.right.equalTo(self.imageView.snp_right).offset(0)
            make.top.equalTo(self.imageView.snp_bottom).offset(10)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.happyLabel)
        self.happyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp_left).offset(0)
            make.width.equalTo(self.titleLabel.snp_width)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(0)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.freeLabel)
        self.freeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.happyLabel.snp_left).offset(0)
            make.width.equalTo(60)
            make.top.equalTo(self.happyLabel.snp_bottom).offset(5)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refreshWithModel(model: CategoryDetailModel) {
        self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
        self.titleLabel.text = model.title
        self.happyLabel.text = model.displayPrice
        self.freeLabel.text = "会员免费"
    }
    
}
