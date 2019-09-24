//
//  IntroductionController.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/26.
//  Copyright © 2019年 HZW. All rights reserved.
//  --简介

import UIKit

class IntroductionController: UIViewController {

    //内容
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = UIColor.black
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    //分割线
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        return line
    }()
    
    //主播介绍
    lazy var anchorLabel: UILabel = {
        let label = UILabel()
        label.text = "主播介绍"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //头像
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //名称
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //关注人数
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //加关注
    lazy var attenionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "np_headview_nofollow_n_23x36_"), for: UIControl.State.normal)
        return button
    }()
    
    //内容简介
    var headInfoModel: HeaderIntroductionModel?
    //主播信息
    var anchorInfoModel: AnchorInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatUI()
    }
    
    //创建UI
    func creatUI() {
        
        self.view.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(ScreenWidth - 20)
            make.top.equalToSuperview().offset(300)
            make.height.equalTo(200)
        }
        
        self.view.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentLabel.snp.left)
            make.right.equalToSuperview()
            make.top.equalTo(self.contentLabel.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        self.view.addSubview(self.anchorLabel)
        self.anchorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentLabel.snp.left)
            make.right.equalToSuperview()
            make.top.equalTo(self.lineView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        self.view.addSubview(self.headImageView)
        self.headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.anchorLabel.snp.left)
            make.width.equalTo(48)
            make.top.equalTo(self.anchorLabel.snp.bottom).offset(10)
            make.height.equalTo(48)
        }
        self.headImageView.layer.cornerRadius = 24
        
        self.view.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImageView.snp.right).offset(10)
            make.width.equalTo(200)
            make.top.equalTo(self.headImageView.snp.top)
            make.height.equalTo(20)
        }

        self.view.addSubview(self.numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.width.equalTo(self.nameLabel.snp.width)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.height.equalTo(self.nameLabel.snp.height)
        }
        
        self.view.addSubview(self.attenionButton)
        self.attenionButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(23)
            make.top.equalTo(self.nameLabel.snp.top)
            make.height.equalTo(36)
        }
        
    }
    
    //刷新数据
    func refreshData() {
        self.contentLabel.text = "内容简介\n\n\(self.headInfoModel!.intro)"
        self.headImageView.kf.setImage(with: URL(string: (self.anchorInfoModel?.smallLogo)!))
        self.nameLabel.text = (self.anchorInfoModel?.nickname)!
        var tagString:String
        if self.anchorInfoModel!.followers > 100000000 {
            tagString = String(format: "%.1f亿", Double(self.anchorInfoModel!.followers) / 100000000)
        } else if self.anchorInfoModel!.followers > 10000 {
            tagString = String(format: "%.1f万", Double(self.anchorInfoModel!.followers) / 10000)
        } else {
            tagString = "\(self.anchorInfoModel!.followers)"
        }
        self.numberLabel.text = "已被\(tagString)人关注"
    }

}
