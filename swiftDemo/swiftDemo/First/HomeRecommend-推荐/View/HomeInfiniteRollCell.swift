//
//  HomeADRollCell.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页顶部滚动页

import UIKit
import FSPagerView

//protocol HomeInfiniteRollCellDelegate {
//    //点击某张广告图
//    func clickImage(_ index: NSInteger)
//}

class HomeInfiniteRollCell: UICollectionViewCell {
    
//    var ADScrollView: WRCycleScrollView?
//    var delegate: HomeInfiniteRollCellDelegate?
    
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
    let imageArray: NSMutableArray = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(150)
        }
        self.pagerView.itemSize = CGSize.init(width: ScreenWidth - 60, height: 140)
        
//        self.ADScrollView = WRCycleScrollView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 200))
//        self.ADScrollView!.imgsType = .SERVER
//        self.ADScrollView!.isAutoScroll = true
//        self.ADScrollView!.imageContentModel = UIView.ContentMode.center
//        self.ADScrollView!.delegate = self
//        self.addSubview(self.ADScrollView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshWithModel(model: FocusModel) {
        for dataModel in model.data! {
            imageArray.add(dataModel.cover as Any)
        }
        self.pagerView.reloadData()
//        self.ADScrollView?.serverImgArray = imageArray as? [String]
    }
}

//extension HomeInfiniteRollCell: WRCycleScrollViewDelegate {
//    //点击图片回调
//    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
//        self.delegate?.clickImage(index)
//    }
//}

extension HomeInfiniteRollCell: FSPagerViewDelegate,FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:self.imageArray[index] as! String))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}
