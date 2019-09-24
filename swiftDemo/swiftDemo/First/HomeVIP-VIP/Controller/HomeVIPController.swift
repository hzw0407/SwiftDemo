//
//  HomeVIPController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页VIP

import UIKit

class HomeVIPController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeVIPBannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(HomeVIPCategoriesCell.self, forCellWithReuseIdentifier: "CategoriesCell")
        collectionView.register(HomeVIPHotCell.self, forCellWithReuseIdentifier: "HotCell")
        collectionView.register(HomeVIPGuessLikeCell.self, forCellWithReuseIdentifier: "guessLikeCell")
        collectionView.register(HomeVIPOtherCellCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    lazy var viewModel: HomeVIPViewModel = {
        let model = HomeVIPViewModel()
        return model
    }()
    
    //下拉刷新
    let header = MJRefreshNormalHeader()
    
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

        self.view.backgroundColor = UIColor.white
        
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
        self.viewModel.successBlock = {
            self.header.endRefreshing()
            self.collectionView.reloadData()
        }
        self.viewModel.failBlock = {
            MBProgressHUD.showErrorInfo("请求失败")
        }
        self.viewModel.loadData()
    }
    
    @objc func MoreClick(btn: UIButton) {
        
    }

}

extension HomeVIPController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.categroyList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            //分类
            return self.viewModel.categroyButtonList?.count ?? 0
        }else if section == 2 || section == 3 {
            //热播、猜你喜欢
            return 3
        }else if section == 4 {
            //大师课
            return self.viewModel.categroyList?[section].list?.count ?? 0
        }else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            //banner
            return CGSize(width: ScreenWidth, height: 150)
        }else if indexPath.section == 1 {
            //分类
            return CGSize(width: 70, height: 80)
        }else if indexPath.section == 2 || indexPath.section == 3 {
            //热播
            return CGSize(width: (ScreenWidth - 40) / 3, height: 200)
        }else {
            //其他
            return CGSize(width: ScreenWidth, height: 110)
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }

    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //头部视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 || indexPath.section == 1 {
                let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID", for: indexPath)
                header.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
                return header
            }else {
                let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
                header.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
                
                let moreView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: ScreenWidth, height: 40))
                moreView.backgroundColor = UIColor.white
                header.addSubview(moreView)
                
                let titleLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: (ScreenWidth - 20) / 2, height: 40))
                let listModel :CategoryListModel = self.viewModel.categroyList![indexPath.section]
                titleLabel.text = listModel.title
                titleLabel.textColor = UIColor.black;
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                moreView.addSubview(titleLabel)
                
                let moreButton: UIButton = UIButton(frame: CGRect(x: ScreenWidth - 10 - 50, y: 0, width: 50, height: 40))
                moreButton.setTitle("更多 >", for: UIControl.State.normal)
                moreButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
                moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                moreButton.tag = 100 + indexPath.section
                moreButton.addTarget(self, action: #selector(MoreClick(btn:)), for: UIControl.Event.touchUpInside)
                moreView.addSubview(moreButton)
                
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    //头部size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 {
            //广告，分类
            return CGSize(width: ScreenWidth, height: 0.01)
        }else {
            return CGSize(width: ScreenWidth, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            //广告
            let cell: HomeVIPBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! HomeVIPBannerCell
            let array = self.viewModel.bannerList
            let emptyArray = NSArray()
            cell.refreshWithImageArray(array:array ?? emptyArray as! [HomeVIPBannerModel])
            return cell
        }else if indexPath.section == 1 {
            //分类
            let cell: HomeVIPCategoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! HomeVIPCategoriesCell
            cell.backgroundColor = UIColor.clear
            let model: CategoryButtonnModel = (self.viewModel.categroyButtonList?[indexPath.row])!
            cell.refreshWithModel(model: model)
            return cell
        }else if indexPath.section == 2 {
            //热播
            let cell: HomeVIPHotCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath) as! HomeVIPHotCell
            cell.backgroundColor = UIColor.clear
            let listModel: CategoryListModel = (self.viewModel.categroyList?[indexPath.section])!
            let model: CategoryDetailModel = listModel.list![indexPath.row]
            cell.refreshWithModel(model: model)
            return cell
        }else if indexPath.section == 3 {
            //猜你喜欢
            let cell: HomeVIPGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "guessLikeCell", for: indexPath) as! HomeVIPGuessLikeCell
            cell.backgroundColor = UIColor.clear
            let listModel: CategoryListModel = (self.viewModel.categroyList?[indexPath.section])!
            let model: CategoryDetailModel = listModel.list![indexPath.row]
            cell.refreshWithModel(model: model)
            return cell
        }else {
            let cell: HomeVIPOtherCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeVIPOtherCellCollectionViewCell
            cell.backgroundColor = UIColor.clear
            let listModel: CategoryListModel = (self.viewModel.categroyList?[indexPath.section])!
            let model: CategoryDetailModel = listModel.list![indexPath.row]
            cell.refreshWithModel(model: model)
            return cell
        }
    }
}
