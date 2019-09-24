//
//  ClassifySubContentController.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/6.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ClassifySubContentController: UIViewController {

    private var keywordId: Int = 0
    private var categoryId: Int = 0
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(ClassifySubMenuCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //数据模型
    private var classifyVerticallist: [ClassifyVerticalModel]?
    
    //下拉刷新
    let MJHeader = MJRefreshNormalHeader()
    
    convenience init(keywordId: Int = 0,categoryId: Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.MJHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.MJHeader.setTitle("松开开始刷新", for: .pulling)
        self.MJHeader.setTitle("拼命加载中...", for: .refreshing)
        self.tableView.mj_header = self.MJHeader
        self.MJHeader.beginRefreshing()
    }

    @objc func headerRefresh() {
        self.loadData()
    }
    
    func loadData() {
        ClassifySubMenuProvider.request(ClassifySubHanddler.classifyOtherContentList(keywordId:self.keywordId, categoryId:self.categoryId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifyVerticalModel>.deserializeModelArrayFrom(json:json["list"].description) { // 从字符串转换为对象实例
                    self.classifyVerticallist = mappedObject as? [ClassifyVerticalModel]
                    self.MJHeader.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension ClassifySubContentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classifyVerticallist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ClassifySubMenuCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassifySubMenuCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let model: ClassifyVerticalModel = (self.classifyVerticallist?[indexPath.row])!
        cell.refreshWithModel(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId: Int = self.classifyVerticallist?[indexPath.row].albumId ?? 0
        let vc: HomeDetailController = HomeDetailController(albumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
