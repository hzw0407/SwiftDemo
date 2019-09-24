//
//  HomeRecommendViewModel.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import HandyJSON

//请求完成 闭包回调
typealias finishend = () -> Void

class HomeRecommendViewModel: NSObject {
    var requestFinish: finishend?
    //首页整体模型
    var homeRecommendList: [HomeRecommendModel]?
    //首页广告模型
    var focusModel: FocusModel?
    //九宫格icon模型
    var squareList: [SquareModel]?
    //猜你喜欢
    var guessLikeList: [RecommendListModel]?
    //精品
    var boutiqueList: [RecommendListModel]?
    //最热有声书
    var hotAudioBookList: [RecommendListModel]?
    //相声评书
    var crossTalkList: [RecommendListModel]?
    //精品听单
    var boutiqueListenList: [RecommendListModel]?
    //亲子时光
    var craftsList: [RecommendListModel]?
    //人文
    var humanityList: [RecommendListModel]?
    //音乐好时光
    var musicTimeList: [RecommendListModel]?
    //live学院
    var liveList: [RecommendListModel]?
    //直播
    var liveBroadcastList: [LiveModel]?
    //综艺娱乐
    var varietyList: [RecommendListModel]?
    //听上海
    var listenSHList: [RecommendListModel]?
}

extension HomeRecommendViewModel {
    //接口请求
    func requestDataSoure() {
        let request = HomeRecommendHanddler.shareInstance
        request.interface = .recommendList
        request.setBaseUrl()
        request.setPathStr()
        request.setParameterDic()
        request.requestHomeDataSoure { (json, errorStr) in
            if json != nil {
                if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description) {
                    self.homeRecommendList = mappedObject.list
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focusModel = focus
                    }
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    //猜你喜欢模型数组
                    let guessLikeArray: NSMutableArray = NSMutableArray()
                    //精品模型数组
                    let boutiqueArray: NSMutableArray = NSMutableArray()
                    //最热有声书模型数组
                    let hotAudioBookArray: NSMutableArray = NSMutableArray()
                    //相声评书模型数组
                    let crossTalkArray: NSMutableArray = NSMutableArray()
                    //精品听单模型数组
                    let boutiqueListenArray: NSMutableArray = NSMutableArray()
                    //亲子时光模型数组
                    let craftsArray: NSMutableArray = NSMutableArray()
                    //人文模型数组
                    let humanityArray: NSMutableArray = NSMutableArray()
                    //音乐好时光模型数组
                    let musicTimeArray: NSMutableArray = NSMutableArray()
                    //live学院模型数组
                    let liveArray: NSMutableArray = NSMutableArray()
                    //综艺娱乐模型数组
                    let varietyArray: NSMutableArray = NSMutableArray()
                    //听上海
                    let listenSHArray: NSMutableArray = NSMutableArray()
                    
                    for index in 0 ..< self.homeRecommendList!.count {
                        let tempModel = self.homeRecommendList![index]
                        if tempModel.moduleId == 4 && tempModel.categoryId == 0 {
                            //猜你喜欢 moduleType = guessYouLike
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                guessLikeArray.add(model)
                            }
                        }else if tempModel.moduleId == 23 && tempModel.categoryId == 0 {
                            //精品 moduleType == "paidCategory"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                boutiqueArray.add(model)
                            }
                        }else if tempModel.moduleId == 20 && tempModel.categoryId == 3 {
                            //最热有声书 moduleType == "categoriesForShort"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                hotAudioBookArray.add(model)
                            }
                        }else if tempModel.moduleId == 20 && tempModel.categoryId == 12 {
                            //相声评书 modleType = "categoriesForShort"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                crossTalkArray.add(model)
                            }
                        }else if tempModel.moduleId == 7 && tempModel.categoryId == 0 {
                            //精品听单 moduleType == "playlist"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                boutiqueListenArray.add(model)
                            }
                        }else if tempModel.moduleId == 13 && tempModel.categoryId == 6 {
                            //亲子时光 moduleType = "categoriesForLong"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                craftsArray.add(model)
                            }
                        }else if tempModel.moduleId == 13 && tempModel.categoryId == 39 {
                            //人文 moduleType == "categoriesForLong"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                humanityArray.add(model)
                            }
                        }else if tempModel.moduleId == 13 && tempModel.categoryId == 2 {
                            //音乐好时光 moduleType == "categoriesForLong"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                musicTimeArray.add(model)
                            }
                        }else if tempModel.moduleId == 29 && tempModel.categoryId == 0 {
                            //live学院 moduleType == "microLesson"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                liveArray.add(model)
                            }
                        }else if tempModel.moduleId == 6 && tempModel.categoryId == 4 {
                            //综艺娱乐 moduleType == "categoriesForExplore"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                varietyArray.add(model)
                            }
                        }else if tempModel.moduleId == 17 && tempModel.categoryId == 0 {
                            //听上海 moduleType == "cityCategory"
                            for i in 0 ..< tempModel.list!.count {
                                let model = tempModel.list![i]
                                listenSHArray.add(model)
                            }
                        }
                    }
                    self.guessLikeList = guessLikeArray as? [RecommendListModel]
                    self.boutiqueList = boutiqueArray as? [RecommendListModel]
                    self.hotAudioBookList = hotAudioBookArray as? [RecommendListModel]
                    self.crossTalkList = crossTalkArray as? [RecommendListModel]
                    self.boutiqueListenList = boutiqueListenArray as? [RecommendListModel]
                    self.craftsList = craftsArray as? [RecommendListModel]
                    self.humanityList = humanityArray as? [RecommendListModel]
                    self.musicTimeList = musicTimeArray as? [RecommendListModel]
                    self.liveList = liveArray as? [RecommendListModel]
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveBroadcastList = live as? [LiveModel]
                    }
                    self.varietyList = varietyArray as? [RecommendListModel]
                    self.listenSHList = listenSHArray as? [RecommendListModel]
                    self.requestFinish?()
                }
            }else {
                print("请求失败")
            }
        }
    }
}
