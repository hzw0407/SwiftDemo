//
//  HomeDetailHeaderView.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/26.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class HomeDetailHeaderView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
    
    //图片
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    //毛玻璃效果
    lazy var blurImageView: UIImageView = {
       let blurImageView = UIImageView()
        return blurImageView
    }()
    
    //标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }()
    
    //昵称图片
    lazy var nickImageView: UIImageView = {
        let nickImageView = UIImageView()
        nickImageView.image = UIImage(named: "album_ic_zhubo_14x14_")
        return nickImageView
    }()
    
    //昵称
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel()
        nickLabel.textColor = UIColor.white
        nickLabel.font = UIFont.systemFont(ofSize: 15)
        return nickLabel
    }()
    
    //分类
    lazy var categoryButton: UIButton = {
        let categoryButton = UIButton()
        //文字靠左，图片靠右
        categoryButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        categoryButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        return categoryButton
    }()
    
    //更新时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.gray
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        return timeLabel
    }()
    
    //订阅
    lazy var subscibeButton: UIButton = {
        let subscibeButton = UIButton()
        subscibeButton.backgroundColor = UIColor.red
        subscibeButton.setTitle("+订阅", for: UIControl.State.normal)
        subscibeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        subscibeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return subscibeButton
    }()
    
    //播放数量图片
    lazy var numberImage: UIImageView = {
        let numberImage = UIImageView()
        numberImage.image = UIImage(named: "playWhite")
        return numberImage
    }()
    
    //播放数量
    lazy var numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textColor = UIColor.white
        numberLabel.font = UIFont.systemFont(ofSize: 15)
        return numberLabel
    }()
    
    //创建UI
    func creatUI() {
        self.blurImageView = UIImageView.init(frame:  CGRect(x:0 , y:0 , width: ScreenWidth, height: self.frame.height - 80))
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = self.blurImageView.bounds
        //        //添加毛玻璃效果层
        self.blurImageView.addSubview(visualEffectView)
        self.insertSubview(self.blurImageView, belowSubview: self)
        
        self.addSubview(self.imageView)
        self.imageView.layer.cornerRadius = 5
        self.imageView.layer.masksToBounds = true
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(64 + 10)
            make.bottom.equalTo(-20)
            make.width.equalTo(120)
        }
        
        self.imageView.addSubview(self.numberImage)
        self.numberImage.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.width.height.equalTo(18)
            make.bottom.equalTo(-5)
        }

        self.imageView.addSubview(self.numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.numberImage.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.numberImage.snp.top)
            make.height.equalTo(self.numberImage.snp.height)
        }

        self.blurImageView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(145)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        }

        self.blurImageView.addSubview(self.nickImageView)
        self.nickImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.width.height.equalTo(25)
            make.bottom.equalToSuperview().offset(-8)
        }

        self.blurImageView.addSubview(self.nickLabel)
        self.nickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nickImageView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(self.nickImageView.snp.height)
            make.bottom.equalTo(self.nickImageView.snp.bottom)
        }

        self.addSubview(self.categoryButton)
        self.categoryButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.nickImageView.snp.left)
            make.width.equalTo(200)
            make.top.equalTo(self.blurImageView.snp.bottom).offset(5)
            make.height.equalTo(30)
        }

        self.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.categoryButton.snp.left)
            make.width.equalTo(self.categoryButton.snp.width)
            make.top.equalTo(self.categoryButton.snp.bottom).offset(5)
            make.height.equalTo(20)
        }

        self.addSubview(self.subscibeButton)
        self.subscibeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(70)
            make.top.equalTo(self.categoryButton.snp.top)
            make.height.equalTo(34)
        }
        self.subscibeButton.layer.cornerRadius = 17;
    }
    
    var headerIntroductionModel: HeaderIntroductionModel? {
        didSet{
            guard let model = headerIntroductionModel else {return}
            self.blurImageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLabel.text = model.title
            self.nickLabel.text = model.nickname
            self.categoryButton.setTitle("\(model.categoryName!)>", for: UIControl.State.normal)
            var tagString:String?
            if model.playTimes > 100000000 {
                tagString = String(format: "%.1f亿", Double(model.playTimes) / 100000000)
            } else if model.playTimes > 10000 {
                tagString = String(format: "%.1f万", Double(model.playTimes) / 10000)
            } else {
                tagString = "\(model.playTimes)"
            }
            self.numberLabel.text = tagString
            self.timeLabel.text = self.updateTimeToCurrennTime(timeStamp: Double(model.updatedAt))
        }
    }
    
    //根据时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat = "yyyy-MM-dd更新"
        return dfmatter.string(from: date as Date)
    }
    

}
