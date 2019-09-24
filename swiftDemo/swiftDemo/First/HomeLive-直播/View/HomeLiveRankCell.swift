//
//  HomeLiveRankCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/7/9.
//  Copyright © 2019 HZW. All rights reserved.
//  --排行榜

import UIKit

class HomeLiveRankCell: UICollectionViewCell {
    
    //父视图
    lazy var totalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
        return view
    }()
    
    //排行榜名称
    lazy var rankName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.totalView)
        self.totalView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview().offset(0)
        }
        
        self.totalView.addSubview(self.rankName)
        self.rankName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refreshWith(model: RankingListModel) {
        self.rankName.text = model.dimensionName
        let number: Int = (model.ranks?.count)!
        for i in 0 ..< number {
            let imageView: UIImageView = UIImageView()
            self.totalView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-(10 + 50 * (2 - i) + 5 * (2 - i)))
                make.width.equalTo(50)
                make.centerY.equalToSuperview()
                make.height.equalTo(50)
            }
            imageView.layer.cornerRadius = 25
            imageView.clipsToBounds = true
            let detailModel: RankDetailModel = (model.ranks?[i])!
            imageView.kf.setImage(with: URL(string: detailModel.coverSmall!))
        }
    }
    
}
