//
//  HomeADRollCell.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页顶部广告滚动

import UIKit

class HomeADRollCell: UICollectionViewCell {
    
    var ADScrollView: WRCycleScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.ADScrollView = WRCycleScrollView(frame: frame)
        self.ADScrollView?.imgsType = .SERVER
        self.ADScrollView?.isAutoScroll = true
        self.addSubview(self.ADScrollView!)
        self.ADScrollView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(200)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshWithModel(model: FocusModel) {
        var imageArray: NSMutableArray = NSMutableArray()
        for dataModel in model.data! {
            imageArray.add(dataModel.cover)
        }
        self.ADScrollView?.serverImgArray = imageArray as? [String]
    }
}
