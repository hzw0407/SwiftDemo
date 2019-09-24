//
//  FiveViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/15.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {
    
    //无限轮播图
    lazy var scrollView: WRCycleScrollView = {
        let imagesArray = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542274166860&di=fc93408b8268894a8d52a9263e949fac&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F017fe85541ae8c000001a64bcc46ea.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542274166859&di=4c518c688e6f1bf54c6e34e461c23888&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F5%2F57b40d52e787e.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542274217900&di=e2d692fb3232d79fb4c42cdcd5913269&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2526878758%2C1925171575%26fm%3D214%26gp%3D0.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542274270063&di=f977235332c479eab625b3ba522b77c4&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fb90e7bec54e736d1cb2b2b2f90504fc2d56269d9.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542274383727&di=40b810e53893b74f2ea5d767d4e7cb17&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F9527735_184105459000_2.jpg"]
        let scrollView = WRCycleScrollView(frame: CGRect(x: 0, y: TopNaviHeight, width: ScreenWidth, height: 200), type: .SERVER, imgs: imagesArray, descs: nil, defaultDotImage: nil, currentDotImage: nil, placeholderImage: nil)
        scrollView.delegate = self as WRCycleScrollViewDelegate
        return scrollView
    }()
    
    let dataArray:[String] = ["瀑布流","二级菜单和collectionView组合","视频播放","新闻-网络请求","选择器","引导页","日历","折线图、饼状图、柱状图","图片预览"]
    var refresh: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "批"
        
        let leftButton:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 44))
        leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        leftButton.setTitle("搜索", for: UIControl.State.normal)
        leftButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton.addTarget(self, action: #selector(leftClick), for: UIControl.Event.touchUpInside)
        let leftItem:UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "image1"), style: UIBarButtonItem.Style.done, target: self, action: #selector(rightClick))
        
        self.view.addSubview(self.scrollView)
        
        let table:UITableView = UITableView(frame:CGRect(x:0,y:TopNaviHeight + scrollView.bounds.size.height,width:ScreenWidth,height:ScreenHeight - TopNaviHeight - scrollView.bounds.size.height - tabBarHeight), style: UITableView.Style.grouped)
        table.backgroundColor = UIColor.white
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        //下拉刷新
        self.refresh = UIRefreshControl.init(frame: CGRect(x: 0, y: 0, width: ScreenHeight, height: 150))
        self.refresh?.tintColor = UIColor.red
        self.refresh?.attributedTitle = NSAttributedString.init(string: "加载中...")
        self.refresh?.addTarget(self, action: #selector(begingRefresh), for: UIControl.Event.valueChanged)
        table.addSubview(self.refresh!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false;
    }
    
    @objc func leftClick(){
        print("点击左侧")
    }
    
    @objc func rightClick(){
        print("点击右侧")
    }
    
    //开始刷新
    @objc func begingRefresh() {
        self.refresh?.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:
            {
                self.refresh?.endRefreshing()
        })
    }

}

extension FiveViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        let title:String = dataArray[indexPath.row]
        cell.textLabel?.text = title
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView(frame: CGRect.zero)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str:String = dataArray[indexPath.row]
        self.tabBarController?.tabBar.isHidden = true
        switch indexPath.row {
        case 0:
            let vc:WaterViewController = WaterViewController()
            vc.textTitle = str
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc:LinkageViewController = LinkageViewController()
            vc.textTitle = str
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc:PlayerViewController = PlayerViewController()
            vc.textTitle = str
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc:AlamofireViewController = AlamofireViewController()
            vc.textTite = str
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc:SelectViewController = SelectViewController()
            vc.testTitle = str
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc: GuideViewController = GuideViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc: CalendarViewController = CalendarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc: ShineChartViewController = ShineChartViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc: phonePreviewViewController = phonePreviewViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}

extension FiveViewController: WRCycleScrollViewDelegate {
    //点击第几张图片
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
        
    }
    
    //滚动到第几张图片
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView) {
        
    }
}
