//
//  HomeClassifyController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页分类

import UIKit

class HomeClassifyController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ClassifyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
        return collectionView
    }()
    
    lazy var viewModel: ClassifyViewModel = {
        let viewModel = ClassifyViewModel()
        return viewModel
    }()
    
    // 顶部刷新
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
    
    //请求数据
    func loadData() {
        self.viewModel.updataBlock = { [unowned self] in
            self.collectionView.reloadData()
        }
        self.viewModel.refreshDataSource()
    }
    
    @objc func headerRefresh() {
        self.viewModel.updataBlock = { [unowned self] in
            self.header.endRefreshing()
            self.collectionView.reloadData()
        }
        self.viewModel.refreshDataSource()
    }

}

extension HomeClassifyController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.classifyModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.classifyModel?[section].itemList?.count ?? 0
    }
    
    //每个item尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            let width = (ScreenWidth - 5 * 3) / 4
            return CGSize(width: width, height: 50)
        }else {
            let width = (ScreenWidth - 5 * 2) / 3
            return CGSize(width: width, height: 50)
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 || section == 1 || section == 2 {
            return 10
        }else {
            return 5
        }
    }
    
    //头部size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return CGSize.zero
        }else {
            return CGSize(width: ScreenWidth, height: 40)
        }
    }
    
    //尾部size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return CGSize(width: ScreenWidth, height: 10)
        }else {
            return CGSize.zero
        }
    }
    
    //头部view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headView: ClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! ClassifyHeaderView
            let model: ClassifyListModel = (self.viewModel.classifyModel?[indexPath.section])!
            headView.refreshWithModel(model: model)
            return headView
        }else {
            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
            return view
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClassifyCell
        let model: ItemList = (self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row])!
        cell.refreshWitModel(model: model, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryId: Int = self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row].itemDetail?.categoryId ?? 0
        var titleStr: String?
        if self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row].itemDetail?.keywordName != nil {
            titleStr = self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row].itemDetail?.keywordName
        }else if self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row].itemDetail?.title != nil {
            titleStr = self.viewModel.classifyModel?[indexPath.section].itemList?[indexPath.row].itemDetail?.title
        }else {
            titleStr = ""
        }
        let vc: ClassifySubMenuController = ClassifySubMenuController()
        vc.titleStr = titleStr
        vc.categoryId = categoryId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
