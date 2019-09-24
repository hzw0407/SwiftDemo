//
//  HomeVIPOtherCellCollectionViewCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/7/5.
//  Copyright © 2019 HZW. All rights reserved.
//

import UIKit

class HomeVIPOtherCellCollectionViewCell: UICollectionViewCell {
    
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
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp_right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.imageView.snp_top).offset(0)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp_left).offset(0)
            make.right.equalTo(self.titleLabel.snp_right).offset(0)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(20)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.playImageView)
        self.playImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitleLabel.snp.left)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(17)
        }
        
        self.addSubview(self.playCountLabel)
        self.playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.playImageView.snp.right).offset(10)
            make.width.equalTo(60)
            make.bottom.equalToSuperview().offset(-10)
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
    
    func refreshWithModel(model: CategoryDetailModel) {
        
        self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.intro
        self.trackLabel.text = "\(model.tracks)集"
        
        var tagString:String?
        if model.playsCounts > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
        } else if model.playsCounts > 10000 {
            tagString = String(format: "%.1f万", Double(model.playsCounts) / 10000)
        } else {
            tagString = "\(model.playsCounts)"
        }
        self.playCountLabel.text = tagString
        
    }
    
}
