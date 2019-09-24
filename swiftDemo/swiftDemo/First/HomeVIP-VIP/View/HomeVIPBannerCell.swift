//
//  HomeVIPBannerCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//  --广告

import UIKit
import FSPagerView

class HomeVIPBannerCell: UICollectionViewCell {
    
    //图片循环滚动
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    //图片数组
    var imageArray: NSArray = NSArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.red
        
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(150)
        }
        self.pagerView.itemSize = CGSize.init(width: ScreenWidth - 60, height: 140)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithImageArray(array:[HomeVIPBannerModel]?) {
        self.imageArray = array! as NSArray
        self.pagerView.reloadData()
    }
    
}

extension HomeVIPBannerCell: FSPagerViewDelegate,FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let model:HomeVIPBannerModel = self.imageArray[index] as! HomeVIPBannerModel
        cell.imageView?.kf.setImage(with: URL(string:model.cover as! String))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}
