//
//  phonePreviewViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/25.
//  Copyright © 2018年 HZW. All rights reserved.
//  --图片预览

import UIKit
import AlamofireImage

class phonePreviewViewController: UIViewController {

    //图片数组
    let imageArray = ["http://img02.tooopen.com/images/20151031/tooopen_sy_147004931368.jpg",
                      "http://picapi.ooopic.com/11/15/91/34b1OOOPIC23.jpg",
                      "http://pic26.nipic.com/20121208/2625614_105723975000_2.jpg",
                      "http://pic39.nipic.com/20140317/4499633_224656064375_2.jpg",
                      "https://b-ssl.duitang.com/uploads/item/201503/27/20150327210803_jFcss.jpeg"]

    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true;
        scrollView.isHidden = true;
        scrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(imageArray.count), height: 0)
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self

        for i in 0 ..< 5 {
            let imageView = UIImageView(frame: CGRect(x: ScreenWidth * CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight))
            let url = NSURL(string: imageArray[i])!
            imageView.af_setImage(withURL: url as URL)
            scrollView.addSubview(imageView)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(hidden(_:)))
        scrollView.addGestureRecognizer(tap)

        return scrollView;
    }()

    lazy var pageContor : UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = imageArray.count
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.isHidden = true
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "图片预览"
        self.view.backgroundColor = UIColor.white

        self.setImage()

        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview().offset(0)
        }

        self.view.addSubview(self.pageContor)
        self.pageContor.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(0)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(15)
        }
        
    }
    
    //设置图片
    func setImage() {
        let imageWidth = (ScreenWidth - 40) / 3
        let space = 10
        for i in 0 ..< 5 {
            let imageView = UIImageView(frame: CGRect(x: 10 + imageWidth * CGFloat(i % 3) + CGFloat(space * (i % 3)), y:TopNaviHeight + 10 + imageWidth * CGFloat(i / 3) + CGFloat(space * (i / 3)), width: imageWidth, height: imageWidth))
            imageView.isUserInteractionEnabled = true
            let url = NSURL(string: imageArray[i])!
            imageView.af_setImage(withURL: url as URL)
            imageView.tag = 100 + i
            self.view.addSubview(imageView)

            let tap = UITapGestureRecognizer(target: self, action: #selector(imageClick(_:)))
            imageView.addGestureRecognizer(tap)
        }
    }

    //点击图片
    @objc func imageClick(_ ges: UITapGestureRecognizer){
        self.navigationController?.isNavigationBarHidden = true
        self.scrollView.isHidden = false
        self.pageContor.isHidden = false
        let index = (ges.view?.tag)! - 100
        self.scrollView.contentOffset = CGPoint(x: ScreenWidth * CGFloat(index), y: 0)
        self.pageContor.currentPage = index
    }

    //隐藏scrollView
    @objc func hidden(_ ges: UITapGestureRecognizer){
        self.navigationController?.isNavigationBarHidden  = false
        self.scrollView.isHidden = true
        self.pageContor.isHidden = true
    }

}

extension phonePreviewViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / ScreenWidth
        self.pageContor.currentPage = NSInteger(index)
    }
}

