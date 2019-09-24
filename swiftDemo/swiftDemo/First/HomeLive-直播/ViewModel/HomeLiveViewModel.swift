//
//  HomeLiveViewModel.swift
//  swiftDemo
//
//  Created by HZW on 2019/7/5.
//  Copyright © 2019 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeLiveViewModel: NSObject {

    override init() {
        super.init()
    }
    
    //滚动图片
    var banerList: [RollBanerModel]?
    //排行榜
    var rankList: [RankingListModel]?
    //直播主播信息
    var liveInfoList: [LivesInfoModel]?
    //是否请求到了数据
    var isGetData: Bool?
    
    //数据回调
    typealias DataBlock = () ->Void
    var dataBlock: DataBlock?
    
}

extension HomeLiveViewModel {
    func loadLiveData(){
        let grpup = DispatchGroup()
        
        self.isGetData = false
        
        grpup.enter()
        //首页直播滚动图接口请求
        HomeLiveProvider.request(.liveBannerList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeLiveBanerModel>.deserializeFrom(json: json.description) {
                    //从字符串转换为对象实例
                    self.banerList = mappedObject.data
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        //首页直播排行榜接口请求
        HomeLiveProvider.request(.liveRankList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeLiveRankModel>.deserializeFrom(json: json.description) {
                    // 从字符串转换为对象实例
                    self.rankList = mappedObject.data?.multidimensionalRankVos
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        //首页直播接口请求
        HomeLiveProvider.request(.liveList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeLiveModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.liveInfoList = mappedObject.data?.lives
                    grpup.leave()
                }
            }
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.isGetData = true
            self.dataBlock?()
        }
    }
}
