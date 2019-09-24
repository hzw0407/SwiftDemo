//
//  ProgramCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/27.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class ProgramCell: UITableViewCell {

    //序号
    lazy var numbelLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    //标题
    lazy var titltLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //播放数量图片
    lazy var playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sound_playtimes_14x14_")
        return imageView
    }()
    
    //播放数量
    lazy var playLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //评论图片
    lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sound_comments_9x8_")
        return imageView
    }()
    
    //评论数
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //时长图片
    lazy var durationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feed_later_duration_14x14_")
        return imageView
    }()
    
    //时长
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //时间
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    //下载按钮
    lazy var downLoadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "downloadAlbum_30x30_"), for: UIControl.State.normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //创建UI
    func creatUI() {
        self.addSubview(self.numbelLabel)
        self.numbelLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titltLabel)
        self.titltLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.numbelLabel.snp.right)
            make.right.equalToSuperview().offset(-100)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.playImageView)
        self.playImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titltLabel.snp.left)
            make.width.equalTo(20)
            make.top.equalTo(self.titltLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.playLabel)
        self.playLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.playImageView.snp.right).offset(5)
            make.width.equalTo(50)
            make.top.equalTo(self.playImageView.snp.top)
            make.height.equalTo(self.playImageView.snp.height)
        }
        
        self.addSubview(self.commentImageView)
        self.commentImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.playLabel.snp.right).offset(10)
            make.width.equalTo(17)
            make.top.equalTo(self.playLabel.snp.top)
            make.height.equalTo(17)
        }
        
        self.addSubview(self.commentLabel)
        self.commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.commentImageView.snp.right).offset(5)
            make.width.equalTo(self.playLabel.snp.width)
            make.top.equalTo(self.commentImageView.snp.top)
            make.height.equalTo(self.playLabel.snp.height)
        }
        
        self.addSubview(self.durationImageView)
        self.durationImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.commentLabel.snp.right).offset(5)
            make.width.equalTo(self.playImageView.snp.width)
            make.top.equalTo(self.commentLabel.snp.top)
            make.height.equalTo(self.playImageView.snp.height)
        }
        
        self.addSubview(self.durationLabel)
        self.durationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.durationImageView.snp.right).offset(5)
            make.width.equalTo(self.commentLabel.snp.width)
            make.top.equalTo(self.durationImageView.snp.top)
            make.height.equalTo(self.commentLabel.snp.height)
        }
        
        self.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(90)
            make.top.equalTo(self.titltLabel.snp.top)
            make.height.equalTo(self.titltLabel.snp.height)
        }
        
        self.addSubview(self.downLoadButton)
        self.downLoadButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.timeLabel.snp.right)
            make.width.equalTo(30)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
    }
    
    //刷新数据
    func refreshWithModel(model:ProgramDetailModel,indexPth:IndexPath) {
        self.numbelLabel.text = "\(indexPth.row)"
        self.titltLabel.text = model.title
        var tagString:String?
        if model.playtimes > 100000000 {
            tagString = String(format: "%.1f亿", Double(model.playtimes) / 100000000)
        } else if model.playtimes > 10000 {
            tagString = String(format: "%.1f万", Double(model.playtimes) / 10000)
        } else {
            tagString = "\(model.playtimes)"
        }
        self.playLabel.text = tagString
        self.commentLabel.text = "\(model.comments)"
        self.durationLabel.text = self.getMMSSFromSS(duration: model.duration)
        self.timeLabel.text = self.updateTimeToCurrennTime(timeStamp: Double(model.createdAt))
    }
    
    //秒数转换成时长
    func getMMSSFromSS(duration:Int)->(String){
        let str_minute = duration / 60
        let str_second = duration % 60
        let format_time = "\(str_minute):\(str_second)"
        return format_time
    }
    
    //根据时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat = "yyyy-MM-dd"
        return dfmatter.string(from: date as Date)
    }

}
