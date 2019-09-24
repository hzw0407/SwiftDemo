//
//  ClassifySubMenuController.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/6.
//  Copyright © 2019年 HZW. All rights reserved.
//  --分类二级主界面

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView

class ClassifySubMenuController: UIViewController {

    public var titleStr: String?
    public var categoryId: Int = 0
    
    private var Keywords:[ClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    
//    convenience init(categoryId: Int = 0) {
//        self.init()
//        self.categoryId = categoryId
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = self.titleStr
        
        self.loadHeaderCategoryData()
    }
    
    //顶部分类接口请求
    func loadHeaderCategoryData(){
        ClassifySubMenuProvider.request(ClassifySubHanddler.headerCategoryList(categoryId: self.categoryId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    // 从字符串转换为对象实例
                    self.Keywords = mappedObject as? [ClassifySubMenuKeywords]
                    for keyword in self.Keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    self.initHeaderView()
                }
            }
        }
    }
    
    // 创建DNSPageStyle，设置样式
    func initHeaderView(){
        let style = DNSPageStyle()
        style.isTitleScrollEnable = true
        style.isScaleEnable = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
        
        // 创建每一页对应的controller
        var viewControllers = [UIViewController]()
        for keyword in self.Keywords! {
            let controller = ClassifySubContentController(keywordId:keyword.keywordId, categoryId:keyword.categoryId)
            viewControllers.append(controller)
        }
        
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: TopNaviHeight, width: ScreenWidth, height: ScreenHeight - TopNaviHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
    }

}
