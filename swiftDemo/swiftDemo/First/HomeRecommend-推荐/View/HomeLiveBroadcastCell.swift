//
//  HomeLiveBroadcastCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/1/11.
//  Copyright © 2019年 HZW. All rights reserved.
//  --直播

import UIKit

class HomeLiveBroadcastCell: UICollectionViewCell {
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5.0
        return imageView
    }()
    
    //播放动画
    lazy var replicatorLayer: ReplicatorLayer = {
        let layer = ReplicatorLayer.init(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
    }()
    
    //类型
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.backgroundColor = UIColor.orange
        typeLabel.layer.cornerRadius = 5.0
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textColor = UIColor.white
        typeLabel.textAlignment = NSTextAlignment.center
        typeLabel.numberOfLines = 0
        return typeLabel
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
        subTitleLabel.numberOfLines = 0
        return subTitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.imageView.addSubview(self.replicatorLayer)
        self.replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
        
        self.imageView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(0)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(20)
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
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //推荐里面的直播
    func refreshWithModel(model:LiveModel) {
        
        if model.coverMiddle != nil {
            self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
        }
        
        let width: CGFloat = (model.categoryName)!.widthForComment(fontSize: 14, height: 20)
        self.typeLabel.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
        self.typeLabel.text = model.categoryName
        
        self.titleLabel.text = model.nickname
        self.subTitleLabel.text = model.name
        
    }
    
    //直播里面的主播信息
    func refreshWithLiveInfoModel(model: LivesInfoModel) {
        
        if model.coverMiddle != nil {
            self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
        }
        
        let width: CGFloat = (model.categoryName)!.widthForComment(fontSize: 14, height: 20)
        self.typeLabel.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
        self.typeLabel.text = model.categoryName
        
        self.titleLabel.text = model.nickname
        self.subTitleLabel.text = model.name
        
    }
    
}

extension String {
    func widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
