//
//  ClassifySubViewModel.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/6.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ClassifySubViewModel: NSObject {

    // 外部传值请求接口如此那
    var categoryId :Int = 0
    convenience init(categoryId: Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    
    var classifyCategoryContentsList:[ClassifyCategoryContentsList]?
    var classifyModuleType14List:[ClassifyModuleType14Model]?
    var classifyModuleType19List:[ClassifyModuleType19Model]?
    var classifyModuleType20Model:[ClassifyModuleType20Model]?
    var classifyVerticalModel:[ClassifyVerticalModel]?
    var focus:FocusModel?
    //数据更新回调
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
    
}

// Mark:-请求数据
extension ClassifySubViewModel {
    func refreshDataSource() {
        //分类二级界面推荐接口请求
        ClassifySubMenuProvider.request(ClassifySubHanddler.classifyRecommendList(categoryId: self.categoryId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifyCategoryContentsList>.deserializeModelArrayFrom(json:json["categoryContents"]["list"].description) { // 从字符串转换为对象实例
                    self.classifyCategoryContentsList = mappedObject as? [ClassifyCategoryContentsList]
                }
                // 顶部滚动视图数据
                if let focusModel = JSONDeserializer<FocusModel>.deserializeFrom(json:json["focusImages"].description) { // 从字符串转换为对象实例
                    self.focus = focusModel
                }
                self.updataBlock?()
            }
        }
    }
}
