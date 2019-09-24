//
//  HomeRecommendHanddler.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeRecommendHanddler: NSObject {

    enum requestType {
        case recommendList//推荐列表
        case recommendForYouList // 为你推荐
        case recommendAdList // 推荐页面穿插的广告
        case guessYouLikeMoreList // 猜你喜欢更多
        case changeGuessYouLikeList // 更换猜你喜欢
        case changePaidCategoryList //更换精品
        case changeLiveList // 更换直播
        case changeOtherCategory(categoryId:Int)// 更换其他
    }
    
    var interface: requestType?
    //服务器地址
    var baseUrl: String?
    //接口地址
    var pathStr: String?
    //参数字典
    var parameterDic: [String:Any] = [:]
    
    static let shareInstance = HomeRecommendHanddler()
    //设置 init 方法私有。防止调用init 方法 破坏类的单一性
    private  override init() {
    }
    
    //设置服务器地址
    func setBaseUrl() {
        switch interface {
        case .recommendAdList?:
            baseUrl = "http://adse.ximalaya.com"
        default:
            baseUrl = "http://mobile.ximalaya.com"
        }
    }

    //设置接口地址
    func setPathStr() {
        switch interface {
        case .recommendList?:
            pathStr = "/discovery-firstpage/v2/explore/ts-1532411485052"
        case .recommendForYouList?:
            pathStr = "/mobile/discovery/v4/recommend/albums"
        case .recommendAdList?:
            pathStr = "/ting/feed/ts-1532656780625"
        case .guessYouLikeMoreList?:
            pathStr = "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
        case .changePaidCategoryList?:
            pathStr = "/mobile/discovery/v1/guessYouLike/paidCategory/ts-1535167980873"
        case .changeLiveList?:
            pathStr = "/lamia/v1/hotpage/exchange"
        case .changeOtherCategory?:
            pathStr = "/mobile/discovery/v4/albums/ts-1535168024113"
        case .changeGuessYouLikeList?:
            pathStr = "/discovery-firstpage/guessYouLike/cycle/ts-1535167862593"
        case .none:
            pathStr = ""
        }
    }
    
    //设置参数字典
    func setParameterDic() {
        switch interface {
        case .recommendList?:
            parameterDic = [
                "device":"iPhone",
                "appid":0,
                "categoryId":-2,
                "channel":"ios-b1",
                "code":"43_310000_3100",
                "includeActivity":true,
                "includeSpecial":true,
                "network":"WIFI",
                "operator":3,
                "pullToRefresh":true,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendForYouList?:
            parameterDic = [
                "device":"iPhone",
                "excludedAlbumIds":"3144231%2C3160816%2C5088879%2C3703879%2C9723091%2C12580785%2C12610571%2C13507836%2C11501536%2C12642314%2C4137349%2C10587045%2C6233693%2C4436043%2C16302530%2C15427120%2C13211141%2C61%2C220565%2C3475911%2C3179882%2C10596891%2C261506%2C7183288%2C203355%2C3493173%2C7054736%2C10728301%2C2688602%2C13048404",
                "appid":0,
                "categoryId":-2,
                "pageId":1,
                "pageSize":20,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendAdList?:
            parameterDic = [
                "device":"iPhone",
                "appid":0,
                "name":"find_native",
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)
            ]
        case .guessYouLikeMoreList?:
            parameterDic = [
                "device":"iPhone",
                "appid":0,
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":20,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .changePaidCategoryList?:
            parameterDic = [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":13616258,
                "excludedOffset":18,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .changeLiveList?:
            parameterDic = [
                "currentRecordIds":"1655918%2C1671613%2C1673030%2C1670774%2C1673082%2C1672407",
                "pageId":1,
                "pageSize":6,
                "device":"iPhone"
            ]
        case .changeOtherCategory(let categoryId)?:
            parameterDic = [
                "appid":0,
                "excludedAlbumIds":"7024810%2C8424399%2C8125936",
                "excludedAdAlbumIds":"13616258",
                "excludedOffset":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
            parameterDic["categoryId"] = categoryId
        case .changeGuessYouLikeList?:
            parameterDic = [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":"8258116%2C8601255%2C16514340",
                "excludedAlbumIds":"4169245%2C4156778%2C4078652%2C8601255%2C4177638%2C16514340%2C5993267%2C12201334%2C13089888%2C4310827%2C4792267%2C2912127%2C13403391%2C4193171%2C5411224%2C8258116%2C4323493%2C10829913",
                "excludedRoomIds":"",
                "excludedSpecialIds":"",
                
                "excludedOffset":18,
                "inreview":false,
                "loopIndex":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":6,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .none:
            pathStr = ""
        }
    }
    
    func requestHomeDataSoure(finished:@escaping(_ json:JSON,_ error:String) -> ()) {
        Alamofire.request(baseUrl! + pathStr!, method: HTTPMethod.get, parameters: parameterDic, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value as Any)
                finished(json,"")
            case .failure:
                finished(JSON.null,response.result.description)
            }
        }
    }
    
}
