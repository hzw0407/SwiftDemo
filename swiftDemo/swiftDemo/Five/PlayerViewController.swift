//
//  PlayerViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/7.
//  Copyright © 2018年 HZW. All rights reserved.
//  --视频播放器

import UIKit
import AVKit
import AVFoundation
import SnapKit

class PlayerViewController: UIViewController {

    //标题
    var textTitle: String?
    //播放信息view
    var infoView: UIView?
    //播放时长
    var playTime: UILabel?
    //进度条
    var playSlider: UISlider?
    //总时长
    var totalTime: UILabel?
    //播放器
    var avPlayer: AVPlayer!
    var avPlayerItem: AVPlayerItem!
    //播放暂停按钮
    var playButton: UIButton?
    //监听播放进度标志
    var timeObserverToken: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = textTitle
        self.view.backgroundColor = UIColor.white
        
        greatUI()
    }

    //创建播放器界面
    func greatUI() {
        
        self.infoView = UIView()
        self.view.addSubview(self.infoView!)
        self.infoView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(self.view.snp.width)
            make.top.equalToSuperview().offset(TopNaviHeight)
            make.height.equalTo(200)
        })
        
        self.playTime = UILabel()
        self.playTime?.text = "00:00:00"
        self.playTime?.textColor = UIColor.white
        self.playTime?.font = UIFont.systemFont(ofSize: 14)
        self.playTime?.textAlignment = NSTextAlignment.left
        self.infoView?.addSubview(self.playTime!)
        self.playTime?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(70)
            make.top.equalTo((self.infoView?.snp.bottom)!).offset(-30)
            make.height.equalTo(20)
        })
        
        self.playSlider = UISlider()
        self.playSlider?.minimumValue = 0
        self.playSlider?.maximumValue = 1
        self.playSlider?.value = 0.0
        self.playSlider?.minimumTrackTintColor = UIColor.orange
        self.playSlider?.maximumTrackTintColor = UIColor.red
        self.playSlider?.addTarget(self, action: #selector(sliderClick(sli:)), for: UIControl.Event.touchUpInside)
        self.infoView?.addSubview(self.playSlider!)
        self.playSlider?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.playTime?.snp.right)!).offset(10)
            make.right.equalToSuperview().offset(-90)
            make.top.equalTo((self.playTime?.snp.top)!).offset(5)
            make.height.equalTo(10)
        })
        
        self.totalTime = UILabel()
        self.totalTime?.textColor = UIColor.white
        self.totalTime?.font = UIFont.systemFont(ofSize: 14)
        self.totalTime?.textAlignment = NSTextAlignment.right
        self.infoView?.addSubview(self.totalTime!)
        self.totalTime?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.playSlider?.snp.right)!).offset(10)
            make.width.equalTo((self.playTime?.snp.width)!)
            make.top.equalTo((self.playTime?.snp.top)!).offset(0)
            make.height.equalTo((self.playTime?.snp.height)!)
        })
        
        self.avPlayerItem = AVPlayerItem(url: NSURL(string: "http://lxdqncdn.miaopai.com/stream/6IqHc-OnSMBIt-LQjPJjmA__.mp4?ssig=a81b90fdeca58e8ea15c892a49bce53f&time_stamp=1508166491488")! as URL)
        self.avPlayer = AVPlayer.init(playerItem: self.avPlayerItem)
        let avPLaylayer = AVPlayerLayer.init(player: self.avPlayer)
        avPLaylayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        avPLaylayer.videoGravity = AVLayerVideoGravity.resize
        self.infoView?.layer.addSublayer(avPLaylayer)
        self.infoView?.layer.insertSublayer(avPLaylayer, at: 0)
        self.avPlayer.play()
        
        self.totalTime?.text = changeTime()
        observerProgress()
        
//        playButton = UIButton(frame: CGRect(x: 150, y: 300, width: 50, height: 50))
        playButton = UIButton()
        playButton?.backgroundColor = UIColor.orange
        playButton?.setTitle("暂停", for: UIControl.State.normal)
        playButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        playButton?.addTarget(self, action: #selector(testClick(btn:)), for: UIControl.Event.touchUpInside)
        playButton?.isSelected = true
        self.view.addSubview(playButton!)
        playButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.top.equalTo((self.infoView?.snp.bottom)!).offset(50)
            make.height.equalTo(50)
        })
    }
    
    //时长转换时分秒
    func changeTime() -> String {
        let total:NSInteger = NSInteger(CMTimeGetSeconds(self.avPlayerItem!.asset.duration))
        let hour:NSInteger = total / 3600
        let min:NSInteger = (total % 3600) / 60
        let sec:NSInteger = total % 60
        return String.init(format: "%02d:%02d:%02d", hour,min,sec)
    }

    //播放暂停
    @objc func testClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            //播放
            self.avPlayer.play()
            btn.setTitle("暂停", for: UIControl.State.normal)
        }else{
            //暂停
            self.avPlayer.pause()
            btn.setTitle("播放", for: UIControl.State.normal)
        }
    }
    
    //拖动进度条
    @objc func sliderClick(sli:UISlider) {
        let value = sli.value
        let duration = value * Float(CMTimeGetSeconds(self.avPlayer.currentItem!.duration))
        let seekTime = CMTimeMake(value: Int64(duration), timescale: 1)
        self.avPlayer.seek(to: seekTime)
    }
    
    //监听播放进度
    func observerProgress() {
        timeObserverToken = self.avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { (time: CMTime) in
            let seconds = Int(CMTimeGetSeconds(time))
            let h = seconds / 60 / 60
            let m = seconds % 3600 / 60
            let s = seconds % 60
            self.playTime?.text = String.init(format: "%02d:%02d:%02d", h,m,s)
            let total = CMTimeGetSeconds(self.avPlayerItem!.asset.duration)
            self.playSlider?.value = Float(CMTimeGetSeconds(time) / total)
        }
    }
    
    deinit {
        if timeObserverToken != nil {
            self.avPlayer.removeTimeObserver(timeObserverToken as Any)
            timeObserverToken = nil
        }
    }
    
}
