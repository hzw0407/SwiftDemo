//
//  HomeGuessLikeMoreController.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/19.
//  Copyright © 2019年 HZW. All rights reserved.
//  --猜你喜欢更多

import UIKit
import HandyJSON
import SwiftyJSON

class HomeGuessLikeMoreController: UIViewController {

    lazy var collectionView:UICollectionView = {
         let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.register(HomeCurrencyTwoCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    //模型数组
    var guessYouLikeList: [GuessYouLikeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "猜你喜欢"

        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(TopNaviHeight)
            make.bottom.equalTo(0)
        }
        
        self.loadData()

}
    
    func loadData(){
        let request = HomeRecommendHanddler.shareInstance
        request.interface = .guessYouLikeMoreList
        request.setBaseUrl()
        request.setPathStr()
        request.setParameterDic()
        request.requestHomeDataSoure { (json, error) in
            if let guessYouLikeModel = JSONDeserializer<GuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                self.guessYouLikeList = guessYouLikeModel as? [GuessYouLikeModel]
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension HomeGuessLikeMoreController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guessYouLikeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCurrencyTwoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCurrencyTwoCell
        let model = self.guessYouLikeList![indexPath.row]
        cell.refreshGuessLikeMore(model: model)
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:ScreenWidth,height:100)
    }

}


