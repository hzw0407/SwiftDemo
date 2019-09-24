//
//  HomeGuessLikeCell.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --猜你喜欢、精品、亲子时光、人文、音乐好时光、live学院、听上海

import UIKit

class HomeCurrencyOneCell: UICollectionViewCell {
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //标题
    lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    //内容
    lazy var contentLabel: UILabel = {
       let contentLabel = UILabel()
        contentLabel.textColor = UIColor.gray;
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.left).offset(0)
            make.right.equalTo(self.imageView.snp.right).offset(0)
            make.top.equalTo(self.imageView.snp.bottom).offset(0)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left).offset(0)
            make.right.equalTo(self.titleLabel.snp.right).offset(0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(0)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithModel(model: RecommendListModel) {
        if model.pic != nil {
            self.imageView.kf.setImage(with: URL(string: model.pic!))
        }
        self.titleLabel.text = model.title;
        self.contentLabel.text = model.subtitle;
    }
    
}
