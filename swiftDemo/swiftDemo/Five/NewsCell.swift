//
//  NewsCell.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/9.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NewsCell: UITableViewCell {

    //标题
    var titleLabel: UILabel?
    //图片view
    var imagesView: UIView?
    //作者
    var authorLable: UILabel?
    //时间
    var dateLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        self.titleLabel = UILabel()
        self.titleLabel?.textColor = UIColor.black
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel?.numberOfLines = 0
        self.addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(0)
        })
        
        self.imagesView = UIView()
        self.imagesView?.backgroundColor = UIColor.clear
        self.addSubview(self.imagesView!)
        self.imagesView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.titleLabel?.snp.left)!).offset(0)
            make.right.equalTo((self.titleLabel?.snp.right)!).offset(0)
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(10)
            make.height.equalTo(200)
        })
        
        self.authorLable = UILabel()
        self.authorLable?.textColor = UIColor.black
        self.authorLable?.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(self.authorLable!)
        self.authorLable?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.titleLabel?.snp.left)!).offset(0)
            make.width.equalTo((self.bounds.width - 20) / 2)
            make.top.equalTo((self.imagesView?.snp.bottom)!).offset(10)
            make.height.equalTo(20)
        })
        
        self.dateLabel = UILabel()
        self.dateLabel?.textColor = UIColor.black
        self.dateLabel?.font = UIFont.systemFont(ofSize: 16)
        self.dateLabel?.textAlignment = NSTextAlignment.right
        self.addSubview(self.dateLabel!)
        self.dateLabel?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo((self.authorLable?.snp.width)!)
            make.top.equalTo((self.authorLable?.snp.top)!).offset(0)
            make.height.equalTo((self.authorLable?.snp.height)!)
        })
        
    }
    
    //刷新数据
    func refreshWithModel(model: NewsModel) {
        self.titleLabel?.text = model.title
        let titleHeight = self.titleLabel?.text?.ga_heightForComment(fontSize: 16, width: UIScreen.main.bounds.size.width - 20, maxHeight: 200)
        self.titleLabel?.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(titleHeight!)
        })
        
        
        if (model.imageArray?.count)! > 0 {
            for i in 0 ..< (model.imageArray?.count)! {
                let imageView = UIImageView()
                let imageStr = (model.imageArray?[i])!
                imageView.kf.setImage(with: URL.init(string: imageStr))
                self.imagesView?.addSubview(imageView)
                let imageWidth = (UIScreen.main.bounds.size.width - 20 - 20) / 3
                imageView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset((imageWidth + 10) * (CGFloat)(i % 3))
                    make.width.equalTo(imageWidth)
                    make.top.equalToSuperview().offset((200 + 10) * (CGFloat)(i / 3))
                    make.height.equalTo(200)
                }
            }
        }
        
        self.authorLable?.text = model.author_name
        self.dateLabel?.text = model.date
    }
    
}
