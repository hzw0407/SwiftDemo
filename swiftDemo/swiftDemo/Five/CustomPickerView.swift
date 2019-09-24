//
//  CustomPickerView.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/13.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

enum selectType: Int {
    case Address = 0//地址
    case Date = 1//日期
}

protocol CustomPickerViewDelegate {
    //返回选择的省市区名称
    func callBackAddress(_ province:String, _ city:String, _ area:String)
    //返回选择的日期
    func callBackDate(_ dateStr:String)
}

class CustomPickerView: UIView {

    //取消、确定按钮view
    lazy var buttonView: UIView = {
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.orange
        
        let buttonArray: NSArray = ["取消","确定"]
        for i in 0 ..< 2 {
            let button: UIButton = UIButton()
            button.backgroundColor = UIColor.purple
            button.setTitle(buttonArray[i] as? String, for: UIControl.State.normal)
            button.setTitleColor(UIColor.white, for: UIControl.State.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.tag = 100 + i
            button.addTarget(self, action: #selector(btnClick(btn:)), for: UIControl.Event.touchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }()
    
    //省市区选择器
    lazy var cityPicker: UIPickerView = {
       let cityPicker = UIPickerView()
        cityPicker.delegate = self;
        cityPicker.dataSource = self;
        return cityPicker
    }()
    
    var delegate: CustomPickerViewDelegate?
    var type: selectType?
    
    //省数据数组
    lazy var provinceArray: NSMutableArray = {
        let provinceArray = NSMutableArray()
        return provinceArray
    }()
    //市数据数组
    lazy var cityArray: NSMutableArray = {
        let cityArray = NSMutableArray()
        return cityArray
    }()
    //区数据数组
    lazy var areaArray: NSMutableArray = {
        let areaArray = NSMutableArray()
        return areaArray
    }()
    //选择的省
    var provinceStr: String?
    //选择的市
    var cityStr: String?
    //选择的区
    var areaStr: String?
    
    //日期选择器
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        //日期的显示样式
        datePicker.datePickerMode = .date
        //日期本地化
        datePicker.locale = Locale.init(identifier: "zh_CN")
        //日历属性
        datePicker.calendar = Calendar.current
        //时区的设置
        datePicker.timeZone = TimeZone.current
        //日期属性的设置
        datePicker.date = Date.init(timeIntervalSinceNow: 100)
        datePicker.addTarget(self, action: #selector(dateStr(picker:)), for: UIControl.Event.valueChanged)
        return datePicker
    }()
    //选择的日期
    var dateStr: String?
    
    init(_ delegate: CustomPickerViewDelegate, _ type: selectType) {
        
        self.delegate = delegate
        self.type = type
        //获取当前年月日
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy年MM月dd日"
        self.dateStr = timeFormatter.string(from: date) as String
        
        super.init(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 300))
        self.backgroundColor = UIColor.red
        
        self.creatUI()
        self.handleCity()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 创建UI
    func creatUI() -> Void {
        self.addSubview(self.buttonView)
        self.buttonView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(50)
        }
        
        let cancelBtn = self.buttonView.viewWithTag(100)
        cancelBtn?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(self.buttonView.snp.height)
        })
        
        let sureBtn = self.buttonView.viewWithTag(101)
        sureBtn?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo((cancelBtn?.snp.width)!)
            make.top.equalTo((cancelBtn?.snp.top)!)
            make.height.equalTo((cancelBtn?.snp.height)!)
        })
        
        switch self.type {
        case .Address?:
            //地址选择
            self.addSubview(self.cityPicker)
            self.cityPicker.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalTo(self.buttonView.snp.bottom).offset(0)
                make.height.equalTo(250)
            }
        case .Date?:
            //日期选择
            self.addSubview(self.datePicker)
            self.datePicker.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalTo(self.buttonView.snp.bottom).offset(0)
                make.height.equalTo(250)
            }
        default:
            break
        }
        
    }
    
    //MARK: 处理省市区数据
    func handleCity() -> Void {
        self.provinceArray.removeAllObjects()
        let path = Bundle.main.path(forResource:"city", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let addressData = NSData.init(contentsOf: url)
        let addressDic = try! JSONSerialization.jsonObject(with: addressData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        let dic = addressDic.object(at: 0) as! NSDictionary
        let provinceArray = dic["childs"] as! NSArray
        for i in 0..<provinceArray.count {
            let provinceDic = provinceArray.object(at: i) as! NSDictionary
            let provinceM = CityModel.init()
            provinceM.region_name = (provinceDic["region_name"] as? String)
            provinceM.region_id = (provinceDic["region_id"] as! String)
            provinceM.agency_id = (provinceDic["agency_id"] as? String)
            provinceM.parent_id = (provinceDic["parent_id"] as! String)
            provinceM.region_type = (provinceDic["region_type"] as! String)
            provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
            self.provinceArray.add(provinceM)
        }
        self.pickerView(self.cityPicker, didSelectRow: 0, inComponent: 0)
    }
    
    //MARK: 按钮点击事件
    @objc func btnClick(btn:UIButton) -> Void {
        if btn.tag == 100 {
            //取消
            self.hiddenPicker()
        }else{
            //确定
            if self.type == .Address {
                //地址
                self.delegate?.callBackAddress(self.provinceStr!, self.cityStr!, self.areaStr!)
            }else{
                //日期
                self.delegate?.callBackDate(self.dateStr!)
            }
            self.hiddenPicker()
        }
    }
    
    //MARK: 日期选择器时间
    @objc func dateStr(picker:UIDatePicker) {
        let  chooseDate = datePicker.date
        let  dateFormater = DateFormatter.init()
        dateFormater.dateFormat = "yyyy年MM月dd日"
        self.dateStr = dateFormater.string(from: chooseDate)
    }
    
    //MARK: 显示选择器
    func showPIcker() -> Void {
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: ScreenHeight - 300, width: ScreenWidth, height: 300)
        }
    }
    
    //MARK: 隐藏选择器
    func hiddenPicker() -> Void {
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 300)
        }
    }
    
}

extension CustomPickerView: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return self.provinceArray.count
        }else if component == 1{
            return self.cityArray.count
        }else{
            return self.areaArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let provinceM = self.provinceArray[row] as! CityModel
            let cityDicArray = provinceM.childs!
            self.cityArray.removeAllObjects()
            for j in 0..<cityDicArray.count {
                let cityDic = cityDicArray[j]
                let cityM = CityModel.init()
                cityM.region_name = (cityDic["region_name"] as? String)
                cityM.region_id = (cityDic["region_id"] as! String)
                cityM.agency_id = (cityDic["agency_id"] as? String)
                cityM.parent_id = (cityDic["parent_id"] as! String)
                cityM.region_type = (cityDic["region_type"] as! String)
                cityM.childs = (cityDic["childs"] as! [NSDictionary])
                self.cityArray.add(cityM)
            }
            // 默认选择当前省的第一个城市对应的区县
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 1)
            self.provinceStr = provinceM.region_name
        }else if component == 1 {
            let cityModel = cityArray[row] as! CityModel
            let areaArray = cityModel.childs!
            self.areaArray.removeAllObjects()
            for j in 0..<areaArray.count {
                let areaDic = areaArray[j]
                let areaModel = CityModel.init()
                areaModel.region_name = (areaDic["region_name"] as? String)
                areaModel.region_id = (areaDic["region_id"] as! String)
                areaModel.agency_id = (areaDic["agency_id"] as? String)
                areaModel.parent_id = (areaDic["parent_id"] as! String)
                areaModel.region_type = (areaDic["region_type"] as! String)
                self.areaArray.add(areaModel)
            }
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 2)
            self.cityStr = cityModel.region_name
        }else{
            let areaModel = self.areaArray[row] as! CityModel
            self.areaStr = areaModel.region_name
        }
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        if component == 0{
            let provinceM = self.provinceArray[row] as! CityModel
            title = provinceM.region_name ?? "未知"
            return title
        }else if component == 1{
            let cityModel = self.cityArray[row] as! CityModel
            title = cityModel.region_name ?? "未知"
            return title
        }else{
            let areaModel = self.areaArray[row] as! CityModel
            title = areaModel.region_name ?? "未知"
            return title
        }
    }
}
