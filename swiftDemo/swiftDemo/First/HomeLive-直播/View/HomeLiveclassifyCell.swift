//
//  HomeLiveclassifyCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/7/9.
//  Copyright © 2019 HZW. All rights reserved.
//  分类cell

import UIKit

class HomeLiveclassifyCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
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
            make.width.equalTo(45)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(45)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalTo(self.imageView.snp_bottom).offset(15)
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refreshWithInfo(image: String, title: String) {
        self.imageView.kf.setImage(with: URL(string: image))
        self.titleLabel.text = title
    }
    
}
