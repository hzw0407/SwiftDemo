//
//  SimilarCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/1.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class SimilarCell: UITableViewCell {

    //图片
    lazy var ImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //是否完结
    lazy var finishLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.init(r: 248, g: 210, b: 74)
        label.text = "完结"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    //标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //子标题
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    //播放量图片
    lazy var playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playCount")
        return imageView
    }()
    
    //播放量
    lazy var playNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    //集数图片
    lazy var tracksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "track")
        return imageView
    }()
    
    //集数
    lazy var tracksLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    //订阅
    lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "recxx_subscribe_56x28_"), for: UIControl.State.normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.creatUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //创建UI
    func creatUI() {
        self.addSubview(self.ImageView)
        self.ImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(80)
            make.top.equalTo(10)
            make.height.equalTo(100)
        }
        
        self.addSubview(self.finishLabel)
        self.finishLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.ImageView.snp.right).offset(10)
            make.width.equalTo(30)
            make.top.equalTo(self.ImageView.snp.top)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.finishLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.finishLabel.snp.top)
            make.height.equalTo(self.finishLabel.snp.height)
        }
        
        self.addSubview(self.subTitleLabel)
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.finishLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
            make.top.equalTo(self.finishLabel.snp.bottom).offset(20)
            make.height.equalTo(self.finishLabel.snp.height)
        }
        
        self.addSubview(self.playImageView)
        self.playImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitleLabel.snp.left)
            make.width.equalTo(17)
            make.bottom.equalTo(self.ImageView.snp.bottom)
            make.height.equalTo(17)
        }
        
        self.addSubview(self.playNumberLabel)
        self.playNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.playImageView.snp.right).offset(10)
            make.width.equalTo(60)
            make.bottom.equalTo(self.playImageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.tracksImageView)
        self.tracksImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.playNumberLabel.snp.right).offset(10)
            make.width.equalTo(20)
            make.bottom.equalTo(self.playNumberLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.tracksLabel)
        self.tracksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.tracksImageView.snp.right).offset(10)
            make.width.equalTo(60)
            make.bottom.equalTo(self.tracksImageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subscribeButton)
        self.subscribeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.equalTo(60)
            make.bottom.equalTo(self.ImageView.snp.bottom)
            make.height.equalTo(30)
        }
    }
    
    //刷新数据
    func refreshWithModel(model:ClassifyVerticalModel) {
        self.ImageView.kf.setImage(with: URL(string: model.coverMiddle!))
        if model.isPaid {
            self.finishLabel.isHidden = true
            self.finishLabel.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
            self.titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.finishLabel.snp.right)
            }
        }
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.intro
        var tagString:String?
        if model.playsCounts > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
        } else if model.playsCounts > 10000 {
            tagString = String(format: "%.1f万", Double(model.playsCounts) / 10000)
        } else {
            tagString = "\(model.playsCounts)"
        }
        self.playNumberLabel.text = tagString
        self.tracksLabel.text = "\(model.tracks)集"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
