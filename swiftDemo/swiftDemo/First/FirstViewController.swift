//
//  ViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/2.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import DNSPageView

class FirstViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "腾"
        self.view.backgroundColor = UIColor.white
        
        self.creatPage()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false;
    }
    
    //创建控制子控制器视图
    func creatPage() {
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScrollEnable = false
        style.isScaleEnable = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
        style.bottomLineHeight = 2
        
        let title = ["推荐","分类","VIP","直播","广播"]
        let viewControllers: [UIViewController] = [HomeRecommendController(),HomeClassifyController(),HomeVIPController(),HomeLiveController(),HomeBroadcastController()]
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: TopNaviHeight, width: ScreenWidth, height: ScreenHeight - TopNaviHeight - tabBarHeight), style: style, titles: title, childViewControllers: viewControllers)
        self.view.addSubview(pageView)
    }

}



