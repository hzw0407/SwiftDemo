//
//  SelectViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/13.
//  Copyright © 2018年 HZW. All rights reserved.
//  --选择器

import UIKit

class SelectViewController: UIViewController {

    var testTitle: String?
    var dataArray : [String]?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = testTitle
        self.view.backgroundColor = UIColor.white
        self.dataArray = ["城市选择","日期选择"]
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: TopNaviHeight, width: self.view.bounds.width, height: self.view.bounds.height - TopNaviHeight), style: UITableView.Style.grouped)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
    }
    
}

extension SelectViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let title = (self.dataArray?[indexPath.row])!
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView(frame: CGRect.zero)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //地址
            let pickerView: CustomPickerView = CustomPickerView.init(self as CustomPickerViewDelegate, .Address)
            self.view.addSubview(pickerView)
            pickerView.showPIcker()
        }else{
            //日期
            let pickerView: CustomPickerView = CustomPickerView.init(self as CustomPickerViewDelegate, .Date)
            self.view.addSubview(pickerView)
            pickerView.showPIcker()
        }
    }
    
}

extension SelectViewController: CustomPickerViewDelegate {
    func callBackAddress(_ province: String, _ city: String, _ area: String) {
        let alertController = UIAlertController(title: "您选择的地方是", message: String.init(format: "%@%@%@", province,city,area), preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        let sureAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func callBackDate(_ dateStr: String) {
        let alertController = UIAlertController(title: "您选择的日期是", message: String.init(format: "%@", dateStr), preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        let sureAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
