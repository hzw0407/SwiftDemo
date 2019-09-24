//
//  SimilarController.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/26.
//  Copyright © 2019年 HZW. All rights reserved.
//  --找相似

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class SimilarController: UIViewController,LTTableViewProtocal {

    lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(SimilarCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var classifyVerticalModel: [ClassifyVerticalModel]?
    var albumd: Int = 0
    
    convenience init(albumd: Int = 0) {
        self.init()
        self.albumd = albumd
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.tableView)
        glt_scrollView = self.tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        self.loadData()
    }
    
    //请求数据
    func loadData() {
        PlayDetailProvider.request(HomeDetailHanddler.playDetailLikeList(albumId: 12825974)) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.classifyVerticalModel = mappedObject as? [ClassifyVerticalModel]
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension SimilarController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classifyVerticalModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SimilarCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SimilarCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let model = self.classifyVerticalModel![indexPath.row]
        cell.refreshWithModel(model:model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
