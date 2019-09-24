//
//  HomeLiveController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页直播

import UIKit

class HomeLiveController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeLiveclassifyCell.self, forCellWithReuseIdentifier: "HomeLiveclassifyCell")
        collectionView.register(HomeLiveBannerCell.self, forCellWithReuseIdentifier: "HomeLiveBannerCell")
        collectionView.register(HomeLiveRankCell.self, forCellWithReuseIdentifier: "HomeLiveRankCell")
        collectionView.register(HomeLiveBroadcastCell.self, forCellWithReuseIdentifier: "HomeLiveBroadcastCell")
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "heanderView")
        return collectionView
    }()
    
    lazy var viewModel: HomeLiveViewModel = {
        let model = HomeLiveViewModel()
        return model
    }()
    
    //下拉刷新
    let header = MJRefreshNormalHeader()
    
    //分类图片
    let classfityImageArray = [
            "http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
            "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
            "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
            "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
            "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png"
    ]
    //分类标题
    let classfityTitleArray = ["温暖男神","心动女神","唱将达人","情感治愈","直播圈子"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview().offset(0)
        }
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        header.setTitle("松开开始刷新", for: .pulling)
        header.setTitle("拼命加载中...", for: .refreshing)
        self.collectionView.mj_header = header
        header.beginRefreshing()
        
    }
    
    @objc func headerRefresh() {
        self.viewModel.dataBlock = {
            self.header.endRefreshing()
            self.collectionView.reloadData()
        }
        self.viewModel.loadLiveData()
    }

}

extension HomeLiveController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.viewModel.isGetData == true {
            return 4
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            //分类
            return 5
        }else if section == 1 {
            //banner
            return 1
        }else if section == 2 {
            //排行榜
            return self.viewModel.rankList?.count ?? 0
        }else{
            //主播模块
            return self.viewModel.liveInfoList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            //分类
            return CGSize(width: (ScreenWidth - 30) / 5, height: 100)
        }else if indexPath.section == 1 {
            //banner
            return CGSize(width: ScreenWidth, height: 110)
        }else if indexPath.section == 2 {
            //排行榜
            return CGSize(width: ScreenWidth, height: 70)
        }else {
            //主播模块
            return CGSize(width: (ScreenWidth - 40) / 2, height: 160)
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 3 {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }else {
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 3 {
            return 10
        }else {
            return 5
        }
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
//    //头部视图
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "heanderView", for: indexPath)
//            view.backgroundColor = UIColor.yellow
//            return view
//        }else {
//            let view: UICollectionReusableView = UICollectionReusableView()
//            return view
//        }
//    }
//
//    //头部大小
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 3 {
//            return CGSize(width: ScreenWidth, height: 40)
//        }else {
//            return CGSize(width: ScreenWidth, height: 0.01)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            //分类
            let cell: HomeLiveclassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeLiveclassifyCell", for: indexPath) as! HomeLiveclassifyCell
            cell.refreshWithInfo(image: self.classfityImageArray[indexPath.row], title: self.classfityTitleArray[indexPath.row])
            return cell
        }else if indexPath.section == 1 {
            //banner
            let cell: HomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeLiveBannerCell", for: indexPath) as! HomeLiveBannerCell
            cell.rollBannerList = self.viewModel.banerList
            return cell
        }else if indexPath.section == 2 {
            //排行榜
            let cell: HomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeLiveRankCell", for: indexPath) as! HomeLiveRankCell
            cell.refreshWith(model: (self.viewModel.rankList?[indexPath.row])!)
            return cell
        }else{
            //主播
            let cell: HomeLiveBroadcastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeLiveBroadcastCell", for: indexPath) as! HomeLiveBroadcastCell
            cell.refreshWithLiveInfoModel(model: (self.viewModel.liveInfoList?[indexPath.row])!)
            return cell
        }
    }
    
}
