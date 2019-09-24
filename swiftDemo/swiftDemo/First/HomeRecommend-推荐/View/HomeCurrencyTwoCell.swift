//
//  HomeCurrencyTwoCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/1/10.
//  Copyright © 2019年 HZW. All rights reserved.
//  --最热有声书、相声评书、精品听单、综艺娱乐

import UIKit

class HomeCurrencyTwoCell: UICollectionViewCell {
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //是否完结
    lazy var endLabel: UILabel = {
        let endLabel = UILabel()
        endLabel.backgroundColor = UIColor.init(red: 248 / 255.0, green: 210 / 255.0, blue: 74 / 255.0, alpha: 1.0)
        endLabel.text = "完结"
        endLabel.textColor = UIColor.white
        endLabel.font = UIFont.systemFont(ofSize: 14)
        endLabel.textAlignment = NSTextAlignment.center
        return endLabel
    }()
    
    //标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
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
    
    //播放图片
    lazy var playImageView: UIImageView = {
        let playImageView = UIImageView()
        playImageView.image = UIImage(named: "playCount")
        return playImageView
    }()
    
    //播放次数
    lazy var playCountLabel: UILabel = {
        let playCountLabel = UILabel()
        playCountLabel.textColor = UIColor.gray
        playCountLabel.font = UIFont.systemFont(ofSize: 14)
        return playCountLabel
    }()
    
    //集数图片
    lazy var trackImageView: UIImageView = {
        let trackImageView = UIImageView()
        trackImageView.image = UIImage(named: "track")
        return trackImageView
    }()
    
    //集数
    lazy var trackLabel: UILabel = {
        let trackLabel = UILabel()
        trackLabel.textColor = UIColor.gray
        trackLabel.font = UIFont.systemFont(ofSize: 14)
        return trackLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.top.bottom.equalToSuperview()
        }
        
        self.addSubview(self.endLabel)
        self.endLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(10)
            make.width.equalTo(30)
            make.top.equalTo(self.imageView.snp.top)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.endLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.endLabel.snp.top)
            make.height.equalTo(self.endLabel.snp.height)
        }
        
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.endLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
            make.top.equalTo(self.endLabel.snp.bottom).offset(20)
            make.height.equalTo(self.endLabel.snp.height)
        }
        
        self.addSubview(self.playImageView)
        self.playImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-1)
            make.width.height.equalTo(17)
        }
        
        self.addSubview(self.playCountLabel)
        self.playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.playImageView.snp.right).offset(10)
            make.width.equalTo(50)
            make.bottom.equalToSuperview()
            make.height.equalTo(self.playImageView.snp.height)
        }
        
        self.addSubview(self.trackImageView)
        self.trackImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.playCountLabel.snp.right).offset(50)
            make.width.equalTo(self.playImageView.snp.height)
            make.bottom.equalTo(self.playImageView.snp.bottom)
            make.height.equalTo(self.playImageView.snp.height)
        }
        
        self.addSubview(self.trackLabel)
        self.trackLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trackImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.trackImageView.snp.bottom)
            make.height.equalTo(self.trackImageView.snp.height)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithModel(model:RecommendListModel){
        if model.pic != nil {
            self.imageView.kf.setImage(with: URL(string: model.pic!))
        }else if model.coverPath != nil {
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
        }
        
        if model.isPaid {
            self.endLabel.isHidden = true
            self.endLabel.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
            self.titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.endLabel.snp.right)
            }
        }
        
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.subtitle
        
        var tagString:String?
        if model.playsCount > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playsCount) / 100000000)
        }else if model.playsCount > 10000000 {
            tagString = String(format: "%.1f千万", Double(model.playsCount) / 10000000)
        }else if model.playsCount > 1000000 {
            tagString = String(format: "%.1ff百万", Double(model.playsCount) / 1000000)
        }else if model.playsCount > 100000 {
            tagString = String(format: "%.1f十万", Double(model.playsCount) / 100000)
        }else if model.playsCount > 10000 {
            tagString = String(format: "%.1f万", Double(model.playsCount) / 10000)
        }else {
            tagString = "\(model.playsCount)"
        }
        self.playCountLabel.text = tagString
        
        self.trackLabel.text = "\(model.tracksCount)集"
        
        
    }
    
    //刷新最热有声书更多列表数据
    func refreshGuessLikeMore(model:GuessYouLikeModel) {
        if model.coverMiddle != nil {
            self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
        }
        
        if model.isPaid {
            self.endLabel.isHidden = true
            self.endLabel.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
            self.titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.endLabel.snp.right)
            }
        }
        
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.recReason
        
        var tagString:String?
        if model.playsCount > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playsCount) / 100000000)
        }else if model.playsCount > 10000000 {
            tagString = String(format: "%.1f千万", Double(model.playsCount) / 10000000)
        }else if model.playsCount > 1000000 {
            tagString = String(format: "%.1ff百万", Double(model.playsCount) / 1000000)
        }else if model.playsCount > 100000 {
            tagString = String(format: "%.1f十万", Double(model.playsCount) / 100000)
        }else if model.playsCount > 10000 {
            tagString = String(format: "%.1f万", Double(model.playsCount) / 10000)
        }else {
            tagString = "\(model.playsCount)"
        }
        self.playCountLabel.text = tagString
        
        self.trackLabel.text = "\(model.tracksCount)集"
    }
    
}
