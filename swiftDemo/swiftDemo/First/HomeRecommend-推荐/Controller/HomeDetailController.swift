//
//  HomeDetailController.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/21.
//  Copyright © 2019年 HZW. All rights reserved.
//  --详情页

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class HomeDetailController: UIViewController {

    private var albumId : Int = 0
    
    //返回按钮
    lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "HomeBack"), for: UIControl.State.normal)
        leftButton.addTarget(self, action: #selector(leftClick), for: UIControl.Event.touchUpInside)
        return leftButton
    }()
    
    //头部以及内容简介模型
    var headerIntroductionModel: HeaderIntroductionModel?
    //主播信息模型
    var anchorInfoModel: AnchorInfoModel?
    //节目列表详情
    var programListModel: ProgramListModel?
    lazy var headerView: HomeDetailHeaderView = {
        let headerView = HomeDetailHeaderView.init(frame: CGRect(x:0, y:0, width:ScreenWidth, height:240))
        headerView.backgroundColor = UIColor.white
        return headerView
    }()
    
    let oneVC: IntroductionController = IntroductionController()
    let twoVC: ProgramController = ProgramController()
    let threeVC: SimilarController = SimilarController()
    let fourVC: CircleController = CircleController()
    
    private lazy var viewControllers: [UIViewController] = {
        return [oneVC,twoVC,threeVC,fourVC]
    }()
    
    private lazy var titles: [String] = {
        return ["简介","节目","找相似","圈子"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 58
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = 20
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    convenience init(albumId: Int = 0) {
        self.init()
        self.albumId = albumId
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        self.view.addSubview(advancedManager)
        
        self.view.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(44)
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.height.equalTo(44)
        }
        
        self.loadData()
    }
    
    @objc func leftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //请求数据
    func loadData() {
        PlayDetailProvider.request(HomeDetailHanddler.playDetailData(albumId:self.albumId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let headerIntroductionModel = JSONDeserializer<HeaderIntroductionModel>.deserializeFrom(json: json["data"]["album"].description) { // 从字符串转换为对象实例
                    self.headerIntroductionModel = headerIntroductionModel
                }
                if let anchorInfoModel = JSONDeserializer<AnchorInfoModel>.deserializeFrom(json: json["data"]["user"].description) { // 从字符串转换为对象实例
                    self.anchorInfoModel = anchorInfoModel
                }
                if let programListModel = JSONDeserializer<ProgramListModel>.deserializeFrom(json: json["data"]["tracks"].description) { // 从字符串转换为对象实例
                    self.programListModel = programListModel
                }
                //传值给headerView
                self.headerView.headerIntroductionModel = self.headerIntroductionModel
                //传值给简介界面
                self.oneVC.headInfoModel = self.headerIntroductionModel
                self.oneVC.anchorInfoModel = self.anchorInfoModel
                self.oneVC.refreshData()
                //传值给节目界面
                self.twoVC.detailModel = self.programListModel
            }
        }
    }

}

extension HomeDetailController: LTAdvancedScrollViewDelegate {
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
//        print("\(offsetY)")
        if offsetY > TopNaviHeight {
            self.leftButton.isHidden = true
        }else {
            self.leftButton.isHidden = false
        }
    }
}
