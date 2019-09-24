//
//  NewsModel.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/9.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsModel: NSObject {

    
    //作者
    var author_name: String?
    var category: String?
    //日期
    var date: String?
    //图片1
    var thumbnail_pic_s: String?
    //图片2
    var thumbnail_pic_s02: String?
    //图片3
    var thumbnail_pic_s03: String?
    //图片数组
    var imageArray: [String]?
    //标题
    var title: String?
    var url: String?
    //文本高度
    var cellHeight: CGFloat?
    
    init(json: JSON) {
        imageArray = [String]()
        author_name = json["author_name"].stringValue
        category = json["category"].stringValue
        date = json["date"].stringValue
        thumbnail_pic_s = json["thumbnail_pic_s"].stringValue
        thumbnail_pic_s02 = json["thumbnail_pic_s02"].stringValue
        thumbnail_pic_s03 = json["thumbnail_pic_s03"].stringValue
        title = json["title"].stringValue
        url  = json["url"].stringValue
        
        if !(thumbnail_pic_s?.isEmpty)! {
            imageArray?.append(thumbnail_pic_s!)
        }
        if !(thumbnail_pic_s02?.isEmpty)! {
            imageArray?.append(thumbnail_pic_s02!)
        }
        if !(thumbnail_pic_s03?.isEmpty)! {
            imageArray?.append(thumbnail_pic_s03!)
        }
        
        let titleHeight = title?.ga_heightForComment(fontSize: 16, width: UIScreen.main.bounds.size.width - 20, maxHeight: 200)
        cellHeight = titleHeight! + (CGFloat)(260)
        
    }
    
}

extension String {
    
    //计算文本宽度
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    //计算文本高度
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
