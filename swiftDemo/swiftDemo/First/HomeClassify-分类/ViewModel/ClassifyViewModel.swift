//
//  ClassifyViewModel.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/5.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ClassifyViewModel: NSObject {

    var classifyModel: [ClassifyListModel]?
    //更新数据回调
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
    
}

// Mark:-请求数据
extension ClassifyViewModel {
    func refreshDataSource() {
        //首页分类接口请求
        HomeClassifProvider.request(.classifyList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<ClassifyModel>.deserializeFrom(json: json.description) {
                    // 从字符串转换为对象实例
                    self.classifyModel = mappedObject.list
                }
                self.updataBlock?()
            }
        }
    }
}
