//
//  HomeVIPHanddler.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//

import Foundation
import Moya

let HomeVIPProvider = MoyaProvider<HomeVIPHanddler>()

//请求分类
public enum HomeVIPHanddler {
    case homeVipList
}

extension HomeVIPHanddler:TargetType {
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .homeVipList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .homeVipList:
            return "/product/v4/category/recommends/ts-1532592638951"
        }
    }
    
    public var method: Moya.Method { return .get }
    public var task: Task {
        let parmeters = [
            "appid":0,
            "categoryId":33,
            "contentType":"album",
            "inreview":false,
            "network":"WIFI",
            "operator":3,
            "scale":3,
            "uid":0,
            "device":"iPhone",
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    public var headers: [String : String]? { return nil }
    
}
