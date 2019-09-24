//
//  GuideViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/19.
//  Copyright © 2018年 HZW. All rights reserved.
//  --引导页

import UIKit

@objc protocol GuideViewControllerDelegate {
    //点击立即体验按钮
    func experienceClick()
}

class GuideViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: ScreenWidth * 3, height: ScreenHeight)
        return scrollView
    }()
    
    //分页控制器
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        return pageControl
    }()
    
    //立即体验按钮
    lazy var experienceButton: UIButton = {
        let experienceButton = UIButton()
        experienceButton.backgroundColor = UIColor.red
        experienceButton.setTitle("立即体验", for: UIControl.State.normal)
        experienceButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        experienceButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        experienceButton.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
        experienceButton.isHidden = true
        return experienceButton
    }()
    
    weak var delagte: GuideViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(self.view).offset(0)
            make.height.equalTo(ScreenHeight)
        }
        let imageArray : NSArray = ["walkthrough_1","walkthrough_2","walkthrough_3"]
        for i in 0 ..< 3 {
            let imageView = UIImageView.init(frame: CGRect(x: ScreenWidth * CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight))
            imageView.image = UIImage(named: imageArray[i] as! String)
            scrollView.addSubview(imageView)
        }
        
        self.view.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(0)
            make.width.equalTo(100)
            make.bottom.equalTo(self.view).offset(0)
            make.height.equalTo(20)
        }
        
        self.view.addSubview(self.experienceButton)
        self.experienceButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(0)
            make.width.equalTo(70)
            make.bottom.equalTo(self.view).offset(-60)
            make.height.equalTo(30)
        }
        
    }
    
    //立即体验
    @objc func btnClick(){
        self.dismiss(animated: true, completion: nil)
        self.delagte?.experienceClick()
    }

}

extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / ScreenWidth
        self.pageControl.currentPage = Int(index)
        
        if index == 2 {
            self.experienceButton.isHidden = false
        }else {
            self.experienceButton.isHidden = true
        }
    }
}
