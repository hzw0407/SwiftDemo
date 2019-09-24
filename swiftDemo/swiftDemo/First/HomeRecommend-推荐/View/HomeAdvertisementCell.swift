//
//  HomeAdvertisementCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/1/10.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class HomeAdvertisementCell: UICollectionViewCell {
    
    //广告图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }()
    
    //子标题
    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.gray
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return subTitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(150)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.left)
            make.right.equalTo(self.imageView.snp.right)
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.height.equalTo(self.titleLabel.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithModel(model: RecommnedAdvertModel) {
        self.imageView.kf.setImage(with: URL(string: model.cover!))
        self.titleLabel.text = model.name
        self.subTitleLabel.text = model.description
    }
    
}
