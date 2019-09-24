//
//  HomeVIPCategoriesCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/20.
//  Copyright © 2019年 HZW. All rights reserved.
//  --分类

import UIKit

class HomeVIPCategoriesCell: UICollectionViewCell {
    
    lazy var imageView:UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titltLable:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.titltLable)
        self.titltLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //刷新数据
    func refreshWithModel(model:CategoryButtonnModel) {
        self.imageView.kf.setImage(with: URL(string: model.coverPath!))
        self.titltLable.text = model.title
    }
    
}
