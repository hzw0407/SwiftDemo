//
//  HomeLiveBannerCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/7/9.
//  Copyright © 2019 HZW. All rights reserved.
//  --滚动banner

import UIKit
import FSPagerView

class HomeLiveBannerCell: UICollectionViewCell {
    
    var bannerList: [RollBanerModel]?
    
    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self as FSPagerViewDelegate
        pagerView.dataSource = self as FSPagerViewDataSource
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.layer.cornerRadius = 5.0
        pagerView.clipsToBounds = true
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "HomeLiveBannerCell")
        return pagerView
    }()
    
    var rollBannerList: [RollBanerModel]? {
        didSet {
            guard let model = rollBannerList else { return }
            self.bannerList = model
            self.pagerView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview().offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension HomeLiveBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell: FSPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeLiveBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.bannerList?[index].cover)!))
        return cell
    }
}
