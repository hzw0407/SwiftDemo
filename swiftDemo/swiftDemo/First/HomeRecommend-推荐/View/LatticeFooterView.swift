//
//  LatticeFooterView.swift
//  swiftDemo
//
//  Created by HZW on 2019/1/2.
//  Copyright © 2019年 HZW. All rights reserved.
//  --九宫格尾部view

import UIKit

class LatticeFooterView: UICollectionReusableView {
    
    //图片
    var imageView: UIImageView?
    //更多
    var moreButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.imageView = UIImageView()
        self.imageView?.image = UIImage.init(named: "news")
        self.addSubview(self.imageView!)
        self.imageView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(25)
        })
        
        self.moreButton = UIButton()
        self.moreButton?.setTitle("| 更多", for: UIControl.State.normal)
        self.moreButton?.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        self.moreButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.moreButton!)
        self.moreButton?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(50)
            make.top.equalTo((self.imageView?.snp.top)!)
            make.height.equalTo((self.imageView?.snp.height)!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
