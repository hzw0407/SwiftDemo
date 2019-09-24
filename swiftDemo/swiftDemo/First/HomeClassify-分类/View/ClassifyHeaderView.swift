//
//  ClassifyHeaderView.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/5.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit

class ClassifyHeaderView: UICollectionReusableView {
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(5)
            make.top.equalTo(10)
            make.bottom.equalTo(-5)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.lineView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.lineView.snp.top)
            make.bottom.equalTo(self.lineView.snp.bottom)
        }
    }
    
    func refreshWithModel(model:ClassifyListModel) {
        self.titleLabel.text = model.groupName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
