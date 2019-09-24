//
//  HomeLatticeCell.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/29.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页顶部九宫格功能

import UIKit

class HomeLatticeCell: UICollectionViewCell {
    
    //icon图标
    var  imageView: UIImageView?
    //icon名称
    var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView()
        self.addSubview(self.imageView!)
        self.imageView!.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        self.nameLabel = UILabel()
        self.nameLabel?.textColor = UIColor.black
        self.nameLabel?.font = UIFont.systemFont(ofSize: 14)
        self.nameLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(self.nameLabel!)
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithModel(model: SquareModel) {
        self.imageView?.kf.setImage(with: URL(string: model.coverPath!))
        self.nameLabel?.text = model.title
    }
    
}
