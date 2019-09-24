//
//  RequestManager.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/8.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//闭包回调
typealias requestFinish = () -> Array<Any>

class RequestManager: NSObject {

    var parameterDic: NSMutableDictionary = [:]
    var urlStr: String?
    var callBack = requestFinish?.self
    
    static let shareInstance = RequestManager()
    //设置 init 方法私有。防止调用init 方法 破坏类的单一性
    private  override init() {
    }
    
    //设置请求参数
    func combinationParams(params:NSDictionary) -> NSDictionary {
        self.parameterDic.addEntries(from: params as! [AnyHashable : Any])
        return self.parameterDic
    }
    
    //get请求
    func getRequest(_finished:@escaping(_ models:[NewsModel]) -> ())  {
//        let dic: NSDictionary = combinationParams(params: params)
        Alamofire.request(urlStr!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            var models = [NewsModel]()
            
            if let value = response.result.value{
                let json = JSON(value)
                let resultDic = json["result"].dictionaryValue
                let resultData = resultDic["data"]?.arrayValue
                for newsData in resultData!{
                    
                    let model = NewsModel.init(json: newsData)
                    models.append(model)
                    
                }
                _finished(models)
        }
    }
}
    
}
