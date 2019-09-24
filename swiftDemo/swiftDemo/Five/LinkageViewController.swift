//
//  LinkageViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/6.
//  Copyright © 2018年 HZW. All rights reserved.
// -- 二级菜单和collectionView组合

import UIKit

class LinkageViewController: UIViewController {

    //标题
    var textTitle: String?
    //collectionView的cell个数 默认点击左边第一个cell
    var itemCount: Int = 1
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = textTitle
        self.view.backgroundColor = UIColor.white
        
        let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: TopNaviHeight, width: 100, height: self.view.bounds.height - TopNaviHeight), style: UITableView.Style.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView)
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 100, y: TopNaviHeight, width: self.view.bounds.width - 100, height: self.view.bounds.height - TopNaviHeight), collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        collectionView?.backgroundColor = UIColor.orange
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
    }

}

extension LinkageViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = String(format: "%zd", indexPath.row)
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
        itemCount = indexPath.row + 1
        refreshCollectionView()
    }
    
    //刷新collectionView
    func refreshCollectionView() {
        collectionView!.reloadData()
    }
    
}

extension LinkageViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(self.view.bounds.width - 100 - 20) / 2, height: 50)
    }
    
}
