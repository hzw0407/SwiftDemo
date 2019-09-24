//
//  HomeVIPViewModel.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeVIPViewModel: NSObject {

    var homeVipModel: HomeVIPModel?
    var bannerList: [HomeVIPBannerModel]?
    var categroyButtonList: [CategoryButtonnModel]?
    var categroyList: [CategoryListModel]?
    
    //数据请求成功回调
    typealias SuccessBlock = () -> Void
    //数据请求失败回调
    typealias FailBlock = () -> Void
    
    var successBlock: SuccessBlock?
    var failBlock: FailBlock?
    
}

extension HomeVIPViewModel {
    //请求数据
    func loadData() {
        HomeVIPProvider.request(.homeVipList, callbackQueue: .none, progress: .none) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeVIPModel>.deserializeFrom(json: json.description) {
                    self.homeVipModel = mappedObject
                    self.bannerList = mappedObject.focusImages?.data
                    self.categroyList = mappedObject.categoryContents?.list
                }
                if let categorybtn = JSONDeserializer<CategoryButtonnModel>.deserializeModelArrayFrom(json:json["categoryContents"]["list"][0]["list"].description){
                    self.categroyButtonList = categorybtn as? [CategoryButtonnModel]
                }
                self.successBlock?()
            }else {
                
                self.failBlock?()
                
            }
        }
    }
}
