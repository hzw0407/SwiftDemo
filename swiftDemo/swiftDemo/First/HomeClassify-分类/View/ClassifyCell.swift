//
//  ClassifyCell.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/5.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class ClassifyCell: UICollectionViewCell {
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //文字
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(5)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    func refreshWitModel(model: ItemList, indexPath:NSIndexPath) {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            //前三个section第一个cell是有图片的
            if model.itemType == 0 {
                //更新约束的时候参照不能变
                self.imageView.snp.updateConstraints { (make) in
                    make.left.equalTo(10)
                    make.width.equalTo(25)
                }
                self.titleLabel.snp.updateConstraints { (make) in
                    make.left.equalTo(self.imageView.snp.right).offset(5)
                    make.right.equalTo(-10)
                }
                self.imageView.isHidden = false
                self.imageView.kf.setImage(with: URL(string: model.coverPath!))
                self.titleLabel.text = model.itemDetail?.title
                self.titleLabel.font = UIFont.systemFont(ofSize: 12)
                self.titleLabel.textAlignment = NSTextAlignment.left
            }else {
                self.imageView.snp.updateConstraints { (make) in
                    make.left.width.equalTo(0)
                }
                self.titleLabel.snp.updateConstraints { (make) in
                    make.left.equalTo(self.imageView.snp.right)
                    make.right.equalTo(0)
                }
                self.imageView.isHidden = true
                self.titleLabel.text = model.itemDetail?.keywordName
                self.titleLabel.font = UIFont.systemFont(ofSize: 15)
                self.titleLabel.textAlignment = NSTextAlignment.center
            }
        }else {
            self.imageView.snp.updateConstraints { (make) in
                make.left.equalTo(10)
                make.width.equalTo(25)
            }
            self.titleLabel.snp.updateConstraints { (make) in
                make.left.equalTo(self.imageView.snp.right).offset(5)
                make.right.equalTo(-10)
            }
            self.imageView.isHidden = false
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            self.titleLabel.text = model.itemDetail?.title
            self.titleLabel.font = UIFont.systemFont(ofSize: 13)
            self.titleLabel.textAlignment = NSTextAlignment.left
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
