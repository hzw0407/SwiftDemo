//
//  AlamofireViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/8.
//  Copyright © 2018年 HZW. All rights reserved.
//  --网络请求

import UIKit

class AlamofireViewController: UIViewController {

    var textTite: String?
    var tableView: UITableView?
    //数据数组
    var dataArray: [NewsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = textTite
        self.view.backgroundColor = UIColor.white
        self.dataArray = [NewsModel]()
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: TopNaviHeight, width: ScreenWidth, height: ScreenHeight - TopNaviHeight), style: UITableView.Style.grouped)
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.view.addSubview(self.tableView!)
        
        let requestM: RequestManager = RequestManager.shareInstance
        requestM.urlStr = "http://v.juhe.cn/toutiao/index?key=d8edd44350a7dcf5f54ce7fdbd7699b3&type=top"
//        requestM.getRequest(params: [1:"one"])
        requestM.getRequest { (modelsArray) in
            self.dataArray = modelsArray
            self.tableView?.reloadData()
        }
    }

}

extension AlamofireViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath) as! NewsCell
        let cell = NewsCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let Model = self.dataArray?[indexPath.row]
        cell.refreshWithModel(model: Model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let Model = self.dataArray?[indexPath.row]
        return (Model?.cellHeight)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.zero)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
