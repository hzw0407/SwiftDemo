//
//  ClassifySubMenuCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/6.
//  Copyright © 2019年 HZW. All rights reserved.
//  --分类二级cell

import UIKit

class ClassifySubMenuCell: UITableViewCell {

    //图片
    lazy var ImageView: UIImageView = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func creatUI() {
        self.addSubview(self.ImageView)
        self.ImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(80)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }

        self.addSubview(self.endLabel)
        self.endLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.ImageView.snp.right).offset(10)
            make.width.equalTo(30)
            make.top.equalTo(self.ImageView.snp.top)
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
            make.bottom.equalTo(self.ImageView.snp.bottom)
            make.width.height.equalTo(17)
        }

        self.addSubview(self.playCountLabel)
        self.playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.playImageView.snp.right).offset(10)
            make.width.equalTo(50)
            make.bottom.equalTo(self.playImageView.snp.bottom)
            make.height.equalTo(self.playImageView.snp.height)
        }

        self.addSubview(self.trackImageView)
        self.trackImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.playCountLabel.snp.right).offset(50)
            make.width.equalTo(self.playImageView.snp.height)
            make.bottom.equalTo(self.playCountLabel.snp.bottom)
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
    
    //刷新数据
    func refreshWithModel(model:ClassifyVerticalModel) {
        self.ImageView.kf.setImage(with: URL(string: model.coverMiddle!))
        
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
        self.subTitleLabel.text = model.intro
        
        var tagString:String?
        if model.playsCounts > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
        }else if model.playsCounts > 10000000 {
            tagString = String(format: "%.1f千万", Double(model.playsCounts) / 10000000)
        }else if model.playsCounts > 1000000 {
            tagString = String(format: "%.1ff百万", Double(model.playsCounts) / 1000000)
        }else if model.playsCounts > 100000 {
            tagString = String(format: "%.1f十万", Double(model.playsCounts) / 100000)
        }else if model.playsCounts > 10000 {
            tagString = String(format: "%.1f万", Double(model.playsCounts) / 10000)
        }else {
            tagString = "\(model.playsCounts)"
        }
        self.playCountLabel.text = tagString
        
        self.trackLabel.text = "\(model.tracks)集"
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
