//
//  PlayProgramController.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/28.
//  Copyright © 2019年 HZW. All rights reserved.
//  --播放节目

import UIKit
import SwiftyJSON
import HandyJSON
import AVKit
import AVFoundation

class PlayProgramController: UIViewController {

    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    var playTrackInfo:PlayTrackInfo?
    var playCommentInfo:[PlayCommentInfo]?
    var userInfo:PlayUserInfo?
    var communityInfo:PlayCommunityInfo?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.gray
        return scrollView
    }()
    
    //头部view
    lazy var headView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        //标题
        let titleLabel: UILabel = UILabel ()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.tag = 100
        view.addSubview(titleLabel)
        
        //图片
        let headImageView: UIImageView = UIImageView()
        headImageView.tag = 101
        view.addSubview(headImageView)
        
        //弹幕
        let barrageButton: UIButton = UIButton()
        barrageButton.setImage(UIImage(named: "NPProDMOff_24x24_"), for: UIControl.State.normal)
        barrageButton.tag = 102
        view.addSubview(barrageButton)
        
        //播放机器
        let machineButton: UIButton = UIButton()
        machineButton.setImage(UIImage(named: "npXPlay_30x30_"), for: UIControl.State.normal)
        machineButton.tag = 103
        view.addSubview(machineButton)
        
        //设置
        let settingButton: UIButton = UIButton()
        settingButton.setImage(UIImage(named: "NPProSet_25x24_"), for: UIControl.State.normal)
        settingButton.tag = 104
        view.addSubview(settingButton)
        
        //进度条
        let slider: UISlider = UISlider()
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: UIControl.State.normal)
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.minimumTrackTintColor = DominantColor
        slider.addTarget(self, action: #selector(change(slider:)), for: UIControl.Event.valueChanged)
        slider.addTarget(self, action: #selector(sliderDragUp(sender:)), for: UIControl.Event.touchUpInside)
        slider.tag = 105
        view.addSubview(slider)
        
        //开始时间
        let startLabel: UILabel = UILabel()
        startLabel.text = "00:00"
        startLabel.textColor = DominantColor
        startLabel.font = UIFont.systemFont(ofSize: 15)
        startLabel.tag = 106
        view.addSubview(startLabel)
        
        //总时长
        let totalLabel: UILabel = UILabel()
        totalLabel.textColor = DominantColor
        totalLabel.font = UIFont.systemFont(ofSize: 15)
        totalLabel.textAlignment = NSTextAlignment.right
        totalLabel.tag = 107
        view.addSubview(totalLabel)
        
        //消息列表
        let messageButton: UIButton = UIButton()
        messageButton.setImage(UIImage(named: "playpage_icon_list_24x24_"), for: UIControl.State.normal)
        messageButton.tag = 108
        view.addSubview(messageButton)
        
        //播放控制view
        let playView: UIView = UIView()
        playView.backgroundColor = UIColor.clear
        playView.tag = 109
        view.addSubview(playView)
        
        //上一曲
        let lastButton: UIButton = UIButton()
        lastButton.setImage(UIImage(named: "toolbar_prev_n_p_24x24_"), for: UIControl.State.normal)
        lastButton.tag = 110
        playView.addSubview(lastButton)
        
        //播放、暂停
        let playButton: UIButton = UIButton()
        playButton.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: UIControl.State.normal)
        playButton.addTarget(self, action: #selector(btnClick(btn:)), for: UIControl.Event.touchUpInside)
        playButton.tag = 111
        playView.addSubview(playButton)
        
        //下一曲
        let nextButton: UIButton = UIButton()
        nextButton.setImage(UIImage(named: "toolbar_next_n_p_24x24_"), for: UIControl.State.normal)
        nextButton.tag = 112
        playView.addSubview(nextButton)
        
        //定时
        let timingButton: UIButton = UIButton()
        timingButton.setImage(UIImage(named: "playpage_icon_timing_24x24_"), for: UIControl.State.normal)
        timingButton.tag = 113
        view.addSubview(timingButton)
        
        return view
    }()
    
    //中间view
    lazy var middleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        //头像
        let middleHeadImageView: UIImageView = UIImageView()
        middleHeadImageView.tag = 200
        view.addSubview(middleHeadImageView)
        
        //标题
        let middleTitleLabel: UILabel = UILabel()
        middleTitleLabel.textColor = UIColor.black
        middleTitleLabel.font = UIFont.systemFont(ofSize: 15)
        middleTitleLabel.tag = 201
        view.addSubview(middleTitleLabel)
        
        //关注
        let focusLabe: UILabel = UILabel()
        focusLabe.textColor = UIColor.gray
        focusLabe.font = UIFont.systemFont(ofSize: 15)
        focusLabe.tag = 202
        view.addSubview(focusLabe)
        
        //礼物
        let giftButton: UIButton = UIButton()
        giftButton.setImage(UIImage(named: "bgImageView"), for: UIControl.State.normal)
        giftButton.tag = 203
        view.addSubview(giftButton)
        
        //言论
        let speechImageView: UIImageView = UIImageView()
        speechImageView.image = UIImage(named: "search_hint_histrack_bg_297x33_")
        speechImageView.tag = 204
        view.addSubview(speechImageView)
        
        let speechLabel: UILabel = UILabel()
        speechLabel.textColor = UIColor.black
        speechLabel.font = UIFont.systemFont(ofSize: 15)
        speechLabel.tag = 205
        speechImageView.addSubview(speechLabel)
        
        return view
    }()
    
    //音频播放器
    var playerItem:AVPlayerItem?
    var player: AVPlayer?
    
    //定时器
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray
        
        let leftButton: UIButton = UIButton()
        leftButton.setImage(UIImage(named: "HomeBack"), for: UIControl.State.normal)
        leftButton.addTarget(self, action: #selector(leftClick), for: UIControl.Event.touchUpInside)
        let leftItem: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.creatUI()
        self.loadData()
    }
    
    //创建UI
    func creatUI() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(TopNaviHeight)
            make.height.equalTo(ScreenHeight - TopNaviHeight)
        }
        
        self.scrollView.addSubview(self.headView)
        self.headView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(0)
            make.height.equalTo(450)
        }
        
        let titleLabel: UILabel = self.headView.viewWithTag(100) as! UILabel
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(30)
            make.height.equalTo(20)
        }
        
        let headImageView: UIImageView = self.headView.viewWithTag(101) as! UIImageView
        headImageView.snp.makeConstraints { (make) in
            make.left.equalTo(60)
            make.right.equalTo(-60)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(200)
        }
        
        let barrageButton: UIButton = self.headView.viewWithTag(102) as! UIButton
        barrageButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(30)
            make.top.equalTo(headImageView.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        
        let settingButton: UIButton = self.headView.viewWithTag(104) as! UIButton
        settingButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.equalTo(barrageButton.snp.width)
            make.top.equalTo(barrageButton.snp.top)
            make.height.equalTo(barrageButton.snp.height)
        }
        
        let machineButton: UIButton = self.headView.viewWithTag(103) as! UIButton
        machineButton.snp.makeConstraints { (make) in
            make.right.equalTo(settingButton.snp.left).offset(-20)
            make.width.equalTo(settingButton.snp.width)
            make.top.equalTo(settingButton.snp.top)
            make.height.equalTo(settingButton.snp.height)
        }
        
        let slider: UISlider = self.headView.viewWithTag(105) as! UISlider
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(barrageButton.snp.bottom).offset(15)
            make.height.equalTo(16)
        }
        
        let startLabel: UILabel = self.headView.viewWithTag(106) as! UILabel
        startLabel.snp.makeConstraints { (make) in
            make.left.equalTo(slider.snp.left)
            make.width.equalTo(100)
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        let totalLabel: UILabel = self.headView.viewWithTag(107) as! UILabel
        totalLabel.snp.makeConstraints { (make) in
            make.right.equalTo(slider.snp.right)
            make.width.equalTo(startLabel.snp.width)
            make.top.equalTo(startLabel.snp.top)
            make.height.equalTo(startLabel.snp.height)
        }
        
        let messageButton: UIButton = self.headView.viewWithTag(108) as! UIButton
        messageButton.snp.makeConstraints { (make) in
            make.left.equalTo(barrageButton.snp.left)
            make.width.equalTo(barrageButton.snp.width)
            make.top.equalTo(startLabel.snp.bottom).offset(10)
            make.height.equalTo(barrageButton.snp.height)
        }
        
        let playView: UIView = self.headView.viewWithTag(109) as! UIView
        playView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.top.equalTo(slider.snp.bottom).offset(15)
            make.height.equalTo(60)
        }
        
        let lastButton: UIButton = playView.viewWithTag(110) as! UIButton
        lastButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        
        let playButton: UIButton = playView.viewWithTag(111) as! UIButton
        playButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let nextButton: UIButton = playView.viewWithTag(112) as! UIButton
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.width.equalTo(lastButton.snp.width)
            make.top.equalTo(lastButton.snp.top)
            make.height.equalTo(lastButton.snp.height)
        }
        
        let timingButton: UIButton = self.headView.viewWithTag(113) as! UIButton
        timingButton.snp.makeConstraints { (make) in
            make.right.equalTo(totalLabel.snp.right)
            make.width.equalTo(messageButton)
            make.top.equalTo(messageButton.snp.top)
            make.height.equalTo(messageButton.snp.height)
        }
        
        self.scrollView.addSubview(self.middleView)
        self.middleView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(scrollView)
            make.top.equalTo(self.headView.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        
        let middleHeadImageView: UIImageView = self.middleView.viewWithTag(200) as! UIImageView
        middleHeadImageView.layer.cornerRadius = 20
        middleHeadImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.height.equalTo(40)
        }
        
        let middleTitleLabel: UILabel = self.middleView.viewWithTag(201) as! UILabel
        middleTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(middleHeadImageView.snp.right).offset(10)
            make.width.equalTo(200)
            make.top.equalTo(middleHeadImageView.snp.top)
            make.height.equalTo(20)
        }
        
        let focusLabe: UILabel = self.middleView.viewWithTag(202) as! UILabel
        focusLabe.snp.makeConstraints { (make) in
            make.left.equalTo(middleTitleLabel.snp.left)
            make.width.equalTo(middleTitleLabel.snp.width)
            make.top.equalTo(middleTitleLabel.snp.bottom)
            make.height.equalTo(middleTitleLabel.snp.height)
        }
        
        let giftButton: UIButton = self.middleView.viewWithTag(203) as! UIButton
        giftButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.equalTo(41)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let speechImageView: UIImageView = self.middleView.viewWithTag(204) as! UIImageView
        speechImageView.snp.makeConstraints { (make) in
            make.left.equalTo(middleHeadImageView.snp.left)
            make.right.equalTo(giftButton.snp.right)
            make.top.equalTo(middleHeadImageView.snp.bottom).offset(10)
            make.height.equalTo(43)
        }
        
        let speechLabel: UILabel = speechImageView.viewWithTag(205) as! UILabel
        speechLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        //自动布局的scrollView需要调用该方法才能设置滚动区域
        self.scrollView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: ScreenWidth, height: self.headView.bounds.height + 10 + self.middleView.bounds.height + 10)
        
    }
    
    //请求数据
    func loadData() {
        PlayProvider.request(PlayProgramHanddler.PlayData(albumId:self.albumId,trackUid:self.trackUid,uid:self.uid)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let playTrackInfo = JSONDeserializer<PlayTrackInfo>.deserializeFrom(json: json["trackInfo"].description) { // 从字符串转换为对象实例
                    self.playTrackInfo = playTrackInfo
                    self.initPlayer()
                }
                if let commentInfo = JSONDeserializer<PlayCommentInfoList>.deserializeFrom(json: json["noCacheInfo"]["commentInfo"].description) {
                    //从字符串转换为对象实例
                    self.playCommentInfo = commentInfo.list
                }
                if let userInfoData = JSONDeserializer<PlayUserInfo>.deserializeFrom(json: json["userInfo"].description) {
                    //从字符串转换为对象实例
                    self.userInfo = userInfoData
                }
                if let communityInfoData = JSONDeserializer<PlayCommunityInfo>.deserializeFrom(json: json["noCacheInfo"]["communityInfo"].description) {
                    //从字符串转换为对象实例
                    self.communityInfo = communityInfoData
                }
                
                self.refreshData()
                
            }
        }
    }
    
    //刷新数据
    func refreshData() {
        
        let titleLabel: UILabel = self.headView.viewWithTag(100) as! UILabel
        titleLabel.text = self.playTrackInfo?.title
        
        let headImageView: UIImageView = self.headView.viewWithTag(101) as! UIImageView
        headImageView.kf.setImage(with: URL(string: (self.playTrackInfo?.coverLarge)!))
        
        let totalLabel: UILabel = self.headView.viewWithTag(107) as! UILabel
        totalLabel.text = self.getMMSSFromSS(duration: (self.playTrackInfo?.duration)!)
        
        let middleHeadImageView: UIImageView = self.middleView.viewWithTag(200) as! UIImageView
        middleHeadImageView.kf.setImage(with: URL(string: (self.userInfo?.smallLogo)!))
        
        let middleTitleLabel: UILabel = self.middleView.viewWithTag(201) as! UILabel
        middleTitleLabel.text = (self.userInfo?.nickname)!
        
        let focusLabe: UILabel = self.middleView.viewWithTag(202) as! UILabel
        var tagString:String?
        if (self.userInfo?.followers)! > 100000000 {
            tagString = String(format: "%.1f亿", Double((self.userInfo?.followers)!) / 100000000)
        } else if (self.userInfo?.followers)! > 10000 {
            tagString = String(format: "%.1f万", Double((self.userInfo?.followers)!) / 10000)
        } else {
            tagString = "\((self.userInfo?.followers)!)"
        }
        focusLabe.text = "已被\(tagString ?? "")人关注"
        
        let speechImageView: UIImageView = self.middleView.viewWithTag(204) as! UIImageView
        let speechLabel: UILabel = speechImageView.viewWithTag(205) as! UILabel
        speechLabel.text = self.userInfo?.personDescribe ?? ""
        
    }
    
    //根据总秒数转换成时分秒
    func getMMSSFromSS(duration:Int)->(String){
        var min = duration / 60
        let sec = duration % 60
        var hour : Int = 0
        if min >= 60 {
            hour = min / 60
            min = min % 60
            if hour > 0 {
                return String(format: "%02d:%02d:%02d", hour, min, sec)
            }
        }
        return String(format: "%02d:%02d", min, sec)
    }
    
    //初始化播放器
    func initPlayer() {
        let playStr: String = self.playTrackInfo?.playUrl64 ?? ""
        self.playerItem = AVPlayerItem(url: URL(string: playStr)!)
        self.player = AVPlayer(playerItem: self.playerItem)
    }
    
    //创建定时器
    func creatTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshTime), userInfo: nil, repeats: true)
    }
    
    //刷新时间
    @objc func refreshTime() {
        let currentTime: CMTime = self.playerItem!.currentTime()
        let currentTimeNum: Int = Int(currentTime.value) / Int(currentTime.timescale)
        let startLabel: UILabel = self.headView.viewWithTag(106) as! UILabel
        startLabel.text = self.getMMSSFromSS(duration: currentTimeNum)
        let totalTime: CMTime = self.playerItem!.duration
        let totalTimeNum: Int = Int(totalTime.value) / Int(totalTime.timescale)
        let slider: UISlider = self.headView.viewWithTag(105) as! UISlider
        slider.value = Float(currentTimeNum) / Float(totalTimeNum)
    }
    
    @objc func leftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //进度条
    @objc func change(slider:UISlider) {
//        let currentTime: CMTime = self.playerItem!.currentTime()
//        let currentTimeNum: Int = Int(currentTime.value) / Int(currentTime.timescale)
//        let totalTime: CMTime = self.playerItem!.duration
//        let totalTimeNum: Int = Int(totalTime.value) / Int(totalTime.timescale)
//        slider.value = Float(currentTimeNum / totalTimeNum)
    }
    
    //拖动进度条
    @objc func sliderDragUp(sender:UISlider) {
        let value = sender.value
        let duration = value * Float(CMTimeGetSeconds((self.player!.currentItem?.duration)!))
        let seekTime = CMTimeMake(value: Int64(duration), timescale: 1)
        self.player?.seek(to: seekTime)
    }
    
    @objc func btnClick(btn:UIButton) {
        if btn.tag == 111 {
            btn.isSelected = !btn.isSelected
            if btn.isSelected {
                //播放
                btn.setImage(UIImage(named: "toolbar_pause_n_p_78x78_"), for: UIControl.State.normal)
                self.player?.play()
                self.creatTimer()
            }else {
                //暂停
                btn.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: UIControl.State.normal)
                self.player?.pause()
            }
        }
    }

}
