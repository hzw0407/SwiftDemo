//
//  WaterButton.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/6.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

class WaterButton: UIButton {

    var wImage:UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame:bounds)
        addSubview(wImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
