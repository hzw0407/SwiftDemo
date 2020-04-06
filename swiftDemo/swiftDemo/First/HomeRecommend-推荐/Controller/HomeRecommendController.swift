//
//  HomeRecommendController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/28.
//  Copyright © 2018年 HZW. All rights reserved.
//  --首页推荐

import UIKit
import HandyJSON

class HomeRecommendController: UIViewController {
    
    //头部、尾部注册id
    private let headerID = "headerID"
    //猜你喜欢、精品头部
    private let headerTypeOne = "headerTypeOne"
    private let footerTypeOne = "footerTypeOne"
    private let latticeFooterID = "latticeFooterID"
    private let footerID = "footerID"
    //cell注册id
    private let Cell = "Cell"
    private let infiniteRollCell = "infiniteRollCell'"
    private let latticeCell = "latticeCell"
    private let currencyOneCell = "currencyOneCell"
    private let currencyTwoCell = "currencyTwoCell"
    private let advertisementCell = "advertisementCell"
    private let liveBroadcastCell = "liveBroadcastCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Cell)
        collectionView.register(HomeInfiniteRollCell.self, forCellWithReuseIdentifier: infiniteRollCell)
        collectionView.register(HomeLatticeCell.self, forCellWithReuseIdentifier: latticeCell)
        collectionView.register(HomeCurrencyOneCell.self, forCellWithReuseIdentifier: currencyOneCell)
        collectionView.register(HomeCurrencyTwoCell.self, forCellWithReuseIdentifier: currencyTwoCell)
        collectionView.register(HomeAdvertisementCell.self, forCellWithReuseIdentifier: advertisementCell)
        collectionView.register(HomeLiveBroadcastCell.self, forCellWithReuseIdentifier: liveBroadcastCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTypeOne)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerTypeOne)
        collectionView.register(LatticeFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: latticeFooterID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        return collectionView
    }()
    
    //数据模型
    lazy var viewModel: HomeRecommendViewModel = {
        return HomeRecommendViewModel()
    }()
    //广告模型数组
    var advertisementList: [RecommnedAdvertModel]?
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview().offset(0)
        }
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        header.setTitle("松开开始刷新", for: .pulling)
        header.setTitle("拼命加载中...", for: .refreshing)
        self.collectionView.mj_header = header
        header.beginRefreshing()
        
    }
    
    //下拉刷新
    @objc func headerRefresh() {
        self.viewModel.requestDataSoure()
        self.viewModel.requestFinish = {
            self.header.endRefreshing()
            self.collectionView.reloadData()
        }
        self.getAdvertisement()
    }
    
    //获取广告
    func getAdvertisement() {
        let request = HomeRecommendHanddler.shareInstance
        request.interface = .recommendAdList
        request.setBaseUrl()
        request.setPathStr()
        request.setParameterDic()
        [request .requestHomeDataSoure(finished: { (json, error) in
            if json != nil {
                if let advertList = JSONDeserializer<RecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    self.advertisementList = advertList as? [RecommnedAdvertModel]
                    self.collectionView.reloadData()
                }
            }else {
                print("广告请求失败")
            }
        })]
    }
    
    //判断九宫格是否有参数
    func getUrlCategoryId(url:String) -> String {
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断参数是单个参数还是多个参数
        if string.contains("&") {
            // 多个参数，分割参数
            let urlComponents = string.split(separator: "&")
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单个参数
            let pairComponents = string.split(separator: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return "nil"
            }
            
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value as AnyObject
        }
        return params["category_id"] as! String
    }
    
    //九宫格跳转
    func latticePush(categoryId:String,title:String,url:String) {
        if url == ""{
            if categoryId == "0"{
                MBProgressHUD.showErrorInfo("接口变了,无法获取数据")
            }else{
                let vc = ClassifySubMenuController()
                vc.categoryId = Int(categoryId)!
                vc.titleStr = title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let vc = HomeWebViewController(url:url)
            vc.titleStr = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //点击更多
    @objc func guessLikeMoreClick(btn:UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        switch btn.tag - 100 {
        case 2:
            //猜你喜欢
            let vc:HomeGuessLikeMoreController = HomeGuessLikeMoreController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            //精品
            print("")
        case 4 :
            //最热有声书
            print("")
        case 5 :
            //相声评书
            print("")
        case 7 :
            //精品听单
            print("")
        case 8:
            //亲子时光
            print("")
        case 9:
            //人文
            print("")
        case 10:
            //音乐好时光
            print("")
        case 12:
            //live学院
            print("")
        case 13:
            //直播
            print("")
        case 14:
            //综艺娱乐
            print("")
        case 15:
            //听上海
            print("")
        default:
            print("")
        }
    }
    
    //点击换一批
    @objc func guessLikeChangeClick(btn:UIButton) {
        
        switch btn.tag - 200 {
        case 2:
            //猜你喜欢
            print("")
        case 3:
            //精品
            print("")
        case 4:
            //最热有声书
            print("")
        case 5:
            //相声评书
            print("")
        case 7:
            //精品听单
            print("")
        case 8:
            //亲自时光
            print("")
        case 9:
            //人文
            print("")
        case 10:
            //音乐好时光
            print("")
        case 12:
            //live学院
            print("")
        case 13:
            //直播
            print("")
        case 14:
            //综艺娱乐
            print("")
        case 15:
            //听上海
            print("")
        default:
            print("")
        }
    }

}

extension HomeRecommendController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.homeRecommendList == nil ? 0 : 16
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            //滚动页
            return 1
        case 1:
            //功能九宫格
            return (self.viewModel.squareList?.count) ?? 0
        case 2:
            //猜你喜欢
            return (self.viewModel.guessLikeList?.count) ?? 0
        case 3:
            //精品
            return (self.viewModel.boutiqueList?.count) ?? 0
        case 4:
            //最热有声书
            return (self.viewModel.hotAudioBookList?.count) ?? 0
        case 5:
            //相声评书
            return (self.viewModel.crossTalkList?.count) ?? 0
        case 6:
            //广告
            return 1
        case 7:
            //精品听单
            return (self.viewModel.boutiqueListenList?.count) ?? 0
        case 8:
            //亲子时光
            return (self.viewModel.craftsList?.count) ?? 0
        case 9:
            //人文
            return (self.viewModel.humanityList?.count) ?? 0
        case 10:
            //音乐好时光
            return (self.viewModel.musicTimeList?.count) ?? 0
        case 11:
            //广告
            return 1
        case 12:
            //live学院
            return (self.viewModel.liveList?.count) ?? 0
        case 13:
            //直播
            return (self.viewModel.liveBroadcastList?.count) ?? 0
        case 14:
            //综艺娱乐
            return (self.viewModel.varietyList?.count) ?? 0
        case 15:
            //听上海
            return (self.viewModel.listenSHList?.count) ?? 0
        default:
            return 0
        }
        
        
//        if section == 0 {
//            //滚动页
//            return 1
//        }else if section == 1 {
//            //功能九宫格
//            return 10
//        }else if section == 2 || section == 13 {
//            //猜你喜欢、直播
//            return 6;
//        }else if section == 3 || section == 4 || section == 5 || section == 8 || section == 9 || section == 10 || section == 12 || section == 14 || section == 15{
//            //精品、最热有声书、相声评书、亲子时光、人文、音乐好时光、live学院、综艺娱乐、听上海
//            return 3
//        }else if section == 6 || section == 11 {
//            //广告
//            return 1
//        }else if section == 7 {
//            //精品听单
//            return 4
//        }
//        else {
//            return 5
//        }
    }
    
    //注册cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            //滚动页
            let cell: HomeInfiniteRollCell = collectionView.dequeueReusableCell(withReuseIdentifier: infiniteRollCell, for: indexPath) as! HomeInfiniteRollCell
//            cell.delegate = (self as HomeInfiniteRollCellDelegate)
            cell.refreshWithModel(model: self.viewModel.focusModel!)
            return cell
        }else if indexPath.section == 1 {
            //九宫格功能
            let cell: HomeLatticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: latticeCell, for: indexPath) as! HomeLatticeCell
            let model = self.viewModel.squareList![indexPath.row]
            cell.refreshWithModel(model: model)
            return cell
        }else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 15 {
            //猜你喜欢、精品、亲子时光、人文、音乐好时光、live学院、听上海
            let cell: HomeCurrencyOneCell = collectionView.dequeueReusableCell(withReuseIdentifier: currencyOneCell, for: indexPath) as! HomeCurrencyOneCell
            if indexPath.section == 2 {
                cell.refreshWithModel(model: self.viewModel.guessLikeList![indexPath.row])
            }else if indexPath.section == 3 {
                cell.refreshWithModel(model: self.viewModel.boutiqueList![indexPath.row])
            }else if indexPath.section == 8 {
                cell.refreshWithModel(model: self.viewModel.craftsList![indexPath.row])
            }else if indexPath.section == 9 {
                cell.refreshWithModel(model: self.viewModel.humanityList![indexPath.row])
            }else if indexPath.section == 10 {
                cell.refreshWithModel(model: self.viewModel.musicTimeList![indexPath.row])
            }else if indexPath.section == 12 {
                cell.refreshWithModel(model: self.viewModel.liveList![indexPath.row])
            }else if indexPath.section == 15 {
                cell.refreshWithModel(model: self.viewModel.listenSHList![indexPath.row])
            }
            return cell
        }else if indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 7 || indexPath.section == 14 {
            //最热有声书、相声评书、精品听单、综艺娱乐
            let cell: HomeCurrencyTwoCell = collectionView.dequeueReusableCell(withReuseIdentifier: currencyTwoCell, for: indexPath) as! HomeCurrencyTwoCell
            if indexPath.section == 4 {
                cell.refreshWithModel(model: self.viewModel.hotAudioBookList![indexPath.row])
            }else if indexPath.section == 5 {
                cell.refreshWithModel(model: self.viewModel.crossTalkList![indexPath.row])
            }else if indexPath.section == 7 {
                cell.refreshWithModel(model: self.viewModel.boutiqueListenList![indexPath.row])
            }else if indexPath.section == 14 {
                cell.refreshWithModel(model: self.viewModel.varietyList![indexPath.row])
            }
            return cell
        }else if indexPath.section == 6 || indexPath.section == 11 {
            //广告
            let cell: HomeAdvertisementCell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCell, for: indexPath) as! HomeAdvertisementCell
            cell.refreshWithModel(model: self.advertisementList![0])
            return cell
        }else if indexPath.section == 13 {
            //直播
            let cell: HomeLiveBroadcastCell = collectionView.dequeueReusableCell(withReuseIdentifier: liveBroadcastCell, for: indexPath) as! HomeLiveBroadcastCell
            cell.refreshWithModel(model: self.viewModel.liveBroadcastList![indexPath.row])
            return cell
        }
        else{
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell, for: indexPath)
            return cell
        }
        
    }
    
    //注册头部、尾部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 7 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 13 || indexPath.section == 14 || indexPath.section == 15 {
                //猜你喜欢、精品、最热有声书、相声评书、精品听单、亲子时光、人文、音乐好时光、live学院、直播、综艺娱乐、听上海
                let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTypeOne, for: indexPath)
                header.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
                
                let moreView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: ScreenWidth, height: 40))
                moreView.backgroundColor = UIColor.white
                header.addSubview(moreView)
                
                let titleLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: (ScreenWidth - 20) / 2, height: 40))
                if indexPath.section == 2 {
                    titleLabel.text = "猜你喜欢"
                }else if indexPath.section == 3 {
                    titleLabel.text = "精品"
                }else if indexPath.section == 4 {
                    titleLabel.text = "最热有声书"
                }else if indexPath.section == 5 {
                    titleLabel.text = "相声评书"
                }else if indexPath.section == 7 {
                    titleLabel.text = "精品听单"
                }else if indexPath.section == 8 {
                    titleLabel.text = "亲子时光"
                }else if indexPath.section == 9 {
                    titleLabel.text = "人文"
                }else if indexPath.section == 10 {
                    titleLabel.text = "音乐好时光"
                }else if indexPath.section == 12 {
                    titleLabel.text = "live学院"
                }else if indexPath.section == 13 {
                    titleLabel.text = "直播"
                }else if indexPath.section == 14 {
                    titleLabel.text = "综艺娱乐"
                }else if indexPath.section == 15 {
                    titleLabel.text = "听上海"
                }
                titleLabel.textColor = UIColor.black
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                moreView.addSubview(titleLabel)
                
                let moreButton: UIButton = UIButton(frame: CGRect(x: ScreenWidth - 10 - 50, y: 0, width: 50, height: 40))
                moreButton.setTitle("更多 >", for: UIControl.State.normal)
                moreButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
                moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                moreButton.tag = 100 + indexPath.section
                moreButton.addTarget(self, action: #selector(guessLikeMoreClick(btn:)), for: UIControl.Event.touchUpInside)
                moreView.addSubview(moreButton)
                
                return header
            }else {
                let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath)
                header.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
                return header
            }
        }else if kind == UICollectionView.elementKindSectionFooter {
            if indexPath.section == 1 {
                //九宫格功能
                let footerView: LatticeFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: latticeFooterID, for: indexPath) as! LatticeFooterView
                return footerView
            }else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 7 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 13 || indexPath.section == 14 || indexPath.section == 15 {
                //猜你喜欢、精品、最热有声书、相声评书、精品听单、亲子时光、人文、音乐好时光、live学院、直播、综艺娱乐、听上海
                let footerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerTypeOne, for: indexPath)
                
                let changeButton: UIButton = UIButton(frame: CGRect(x: (ScreenWidth - 80) / 2, y: 10, width: 80, height: 30))
                changeButton.backgroundColor = UIColor.init(red: 255 / 255.0, green: 228 / 255.0, blue: 196 / 255.0, alpha: 1.0)
                changeButton.setTitle("换一批", for: UIControl.State.normal)
                changeButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
                changeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                changeButton.tag = 200 + indexPath.section
                changeButton.addTarget(self, action: #selector(guessLikeChangeClick(btn:)), for: UIControl.Event.touchUpInside)
                footerView.addSubview(changeButton)
                
                return footerView
            }
            else {
                let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID, for: indexPath)
                return footer
            }
        }
        return UICollectionReusableView()
    }
    
    //头部size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 || section == 3 || section == 4 || section == 5 || section == 7 || section == 8 || section == 9 || section == 10 || section == 12 || section == 13 || section == 14 || section == 15 {
            //猜你喜欢、精品、最热有声书、相声评书、精品听单、亲子时光、人文、音乐好时光、live学院、直播、综艺娱乐、听上海
            return CGSize(width: ScreenWidth, height: 50)
        }else if section == 6 || section == 11 {
            //广告
            return CGSize(width: ScreenWidth, height: 10)
        }
        else {
            return CGSize(width: ScreenWidth, height: 0.01)
        }
    }
    
    //尾部size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            //九宫格功能
            return CGSize(width: ScreenWidth, height: 35)
        }else if section == 2 || section == 3 || section == 4 || section == 5 || section == 7 || section == 8 || section == 9 || section == 10 || section == 12 || section == 13 || section == 14 || section == 15 {
            //猜你喜欢、精品、最热有声书、相声评书、精品听单、亲子时光、人文、音乐好时光、live学院、直播、综艺娱乐、听上海
            return CGSize(width: ScreenWidth, height: 50)
        }
        else {
            return CGSize(width: ScreenWidth, height: 0.01)
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 || section == 3 || section == 8 || section == 9 || section == 10 || section == 12 || section == 13 || section == 15 {
            //猜你喜欢、精品、亲子时光、人文、音乐好时光、live学院、直播、听上海
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //每个item尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            //滚动页
            return CGSize(width: ScreenWidth, height: 150)
        }else if indexPath.section == 1 {
            //九宫格功能
            let width = (ScreenWidth - 50) / 5
            return CGSize(width: width, height: 80)
        }else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 13 || indexPath.section == 15 {
            //猜你喜欢、精品、亲子时光、人文、音乐好时光、live学院、直播、听上海
            let width = (ScreenWidth - 40) / 3
            return CGSize(width: width, height: 160);
        }else if indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 7 || indexPath.section == 14 {
            //最热有声书、相声评书、精品听单、综艺娱乐
            return CGSize(width: ScreenWidth, height: 100)
        }else if indexPath.section == 6 || indexPath.section == 11 {
            //广告
            return CGSize(width: ScreenWidth, height: 210)
        }
        else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        if indexPath.section == 1 {
            //九宫格
            guard let string = self.viewModel.squareList?[indexPath.row].properties?.uri else {
                let categoryId:String = "0"
                let title:String = self.viewModel.squareList?[indexPath.row].title ?? ""
                let url:String = self.viewModel.squareList?[indexPath.row].url ?? ""
                self.latticePush(categoryId: categoryId, title: title, url: url)
                return
            }
            let categoryId:String = getUrlCategoryId(url:string)
            let title:String = self.viewModel.squareList?[indexPath.row].title ?? ""
            let url:String = self.viewModel.squareList?[indexPath.row].url ?? ""
            self.latticePush(categoryId: categoryId, title: title, url: url)
        }else {
            var model: RecommendListModel?
            if indexPath.section == 2 {
                //猜你喜欢
                model = self.viewModel.guessLikeList?[indexPath.row]
            }else if indexPath.section == 3 {
                //精品
                model = self.viewModel.boutiqueList?[indexPath.row]
            }else if indexPath.section == 4 {
                //最热有声书
                model = self.viewModel.hotAudioBookList?[indexPath.row]
            }else if indexPath.section == 5 {
                //相声评书
                model = self.viewModel.crossTalkList?[indexPath.row]
            }else if indexPath.section == 8 {
                //亲子时光
                model = self.viewModel.craftsList?[indexPath.row]
            }else if indexPath.section == 9 {
                //人文
                model = self.viewModel.humanityList?[indexPath.row]
            }else if indexPath.section == 10 {
                //音乐好时光
                model = self.viewModel.musicTimeList?[indexPath.row]
            }else if indexPath.section == 14 {
                //综艺娱乐
                model = self.viewModel.varietyList?[indexPath.row]
            }else if indexPath.section == 15 {
                //听上海
                model = self.viewModel.listenSHList?[indexPath.row]
            }else {
                let alertController: UIAlertController = UIAlertController(title: nil, message: "暂无接口", preferredStyle: UIAlertController.Style.alert)
                let action: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let vc: HomeDetailController = HomeDetailController(albumId: model?.albumId ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

//extension HomeRecommendController: HomeInfiniteRollCellDelegate {
//    //点击某张广告图
//    func clickImage(_ index: NSInteger) {
//
//    }
//}
