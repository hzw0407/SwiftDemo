//
//  ClassifyModel.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/5.
//  Copyright © 2019年 HZW. All rights reserved.
//

import Foundation
import HandyJSON

struct ClassifyModel: HandyJSON {
    var list:[ClassifyListModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}

struct ClassifyListModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList:[ItemList]?
}

struct ItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: ItemDetail?
}

struct ItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}
