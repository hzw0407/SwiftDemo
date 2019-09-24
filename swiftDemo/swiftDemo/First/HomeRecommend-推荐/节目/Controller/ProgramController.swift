//
//  ProgramController.swift
//  swiftDemo
//
//  Created by HZW on 2019/2/26.
//  Copyright © 2019年 HZW. All rights reserved.
//  --节目

import UIKit
import LTScrollView

class ProgramController: UIViewController, LTTableViewProtocal {

    lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(ProgramCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var detailModel: ProgramListModel?
    
    var programDetailModel: ProgramListModel? {
        didSet {
            guard let model = programDetailModel else {return}
            self.detailModel = model
            self.tableView.reloadData()
        }
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
        
    }

}

extension ProgramController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailModel?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgramCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let tempModel = self.detailModel?.list?[indexPath.row]
        cell.refreshWithModel(model: tempModel!, indexPth: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempModel = self.detailModel?.list?[indexPath.row]
        let vc: PlayProgramController = PlayProgramController(albumId: (tempModel?.albumId)!, trackUid: (tempModel?.trackId)!, uid: (tempModel?.uid)!)
        let navVC: UINavigationController = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true, completion: nil)
    }
}
