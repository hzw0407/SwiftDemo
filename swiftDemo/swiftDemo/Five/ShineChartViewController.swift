//
//  ShineChartViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/22.
//  Copyright © 2018年 HZW. All rights reserved.
//  --折线图、饼状图、柱状图

import UIKit

class ShineChartViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "折线图、饼状图、柱状图"
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalToSuperview().offset(TopNaviHeight)
            make.bottom.equalToSuperview().offset(0)
        }
        
        //折线图
        let lineLabel = UILabel()
        lineLabel.text = "折线图"
        lineLabel.font = UIFont.systemFont(ofSize: 16)
        lineLabel.textAlignment = NSTextAlignment.center
        self.scrollView.addSubview(lineLabel)
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.scrollView.snp.left).offset(0)
            make.width.equalTo(self.scrollView.snp.width)
            make.top.equalTo(self.scrollView.snp.top).offset(0)
            make.height.equalTo(20)
        }
        
        let lineOne = ShineLine.init(color: UIColor.red, source: [0.2,0.5,0.8,0.4,0.7], lineWidth: 1.5, nodeColor: nil, nodeRadius: 0.5)
        let lineTwo = ShineLine.init(color: UIColor.yellow, source: [0.8,1.5,1.9,1.5,2.3], lineWidth: 1.5, nodeColor: nil, nodeRadius: 0.5)
        let lineChart = ShineLineChart.init(frame: CGRect.zero, xItems: ["1","2","3","4","5"])
        //y轴最大值
        lineChart.maxValue = 3
        //y轴坐标点个数
        lineChart.yItemCount = 5
        lineChart.lines = [lineOne,lineTwo]
        lineChart.duration = 1.5
        lineChart.xShaftTitle = "X"
        lineChart.yShaftTitle = "Y"
        //样式为折线
        lineChart.style = .line
        self.scrollView.addSubview(lineChart)
        lineChart.snp.makeConstraints { (make) in
            make.left.equalTo(self.scrollView.snp.left).offset(10)
            make.width.equalTo(self.scrollView.snp.width).offset(-20)
            make.top.equalTo(lineLabel.snp.bottom).offset(10)
            make.height.equalTo(200)
        }
        
        //散点图
        let scatterLabel = UILabel()
        scatterLabel.text = "散点图"
        scatterLabel.font = UIFont.systemFont(ofSize: 16)
        scatterLabel.textAlignment = NSTextAlignment.center
        self.scrollView.addSubview(scatterLabel)
        scatterLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineLabel.snp.left).offset(0)
            make.right.equalTo(lineLabel.snp.right).offset(0)
            make.top.equalTo(lineChart.snp.bottom).offset(10)
            make.height.equalTo(lineLabel.snp.height)
        }
        
        let scatterOne = ShineLine.init(color: UIColor.purple, source: [0.2,0.5,0.8,0.4,0.7], lineWidth: 5, nodeColor: nil, nodeRadius: 5)
        let scatterTwo = ShineLine.init(color: UIColor.blue, source: [0.8,1.5,1.9,1.5,2.3], lineWidth: 5, nodeColor: nil, nodeRadius: 5)
        let lineChartTwo = ShineLineChart.init(frame: CGRect.zero, xItems: ["1","2","3","4","5"])
        //y轴最大值
        lineChartTwo.maxValue = 3
        //y轴坐标点个数
        lineChartTwo.yItemCount = 5
        lineChartTwo.lines = [scatterOne,scatterTwo]
        lineChartTwo.duration = 1.5
        //x轴标题
        lineChartTwo.xShaftTitle = "X"
        //y轴标题
        lineChartTwo.yShaftTitle = "Y"
        //样式为折线
        lineChartTwo.style = .scatter
        self.scrollView.addSubview(lineChartTwo)
        lineChartTwo.snp.makeConstraints { (make) in
            make.left.equalTo(lineChart.snp.left).offset(0)
            make.right.equalTo(lineChart.snp.right).offset(0)
            make.top.equalTo(scatterLabel.snp.bottom).offset(10)
            make.height.equalTo(lineChart.snp.height)
        }
        
        //柱状图
        let columnarLabel = UILabel()
        columnarLabel.text = "柱状图"
        columnarLabel.font = UIFont.systemFont(ofSize: 16)
        columnarLabel.textAlignment = NSTextAlignment.center
        self.scrollView.addSubview(columnarLabel)
        columnarLabel.snp.makeConstraints { (make) in
            make.left.equalTo(scatterLabel.snp.left).offset(0)
            make.right.equalTo(scatterLabel.snp.right).offset(0)
            make.top.equalTo(lineChartTwo.snp.bottom).offset(10)
            make.height.equalTo(scatterLabel.snp.height)
        }
        
        let barOne = ShineBar.init(color: UIColor.red, value: [0.5,0.8,1.2,0.7,0.9])
        let barTwo = ShineBar.init(color: UIColor.purple, value: [0.2,0.6,0.9,0.5,0.7])
        let bar = ShineBarChart.init(frame: CGRect.zero, xItems: ["1","2","3","4","5"])
        bar.bars = [barOne,barTwo]
        bar.maxValue = 1.5
        bar.yItemCount = 5
        bar.duration = 1.5
        //柱子的宽度
        bar.itemWidth = 40
        self.scrollView.addSubview(bar)
        bar.snp.makeConstraints { (make) in
            make.left.equalTo(lineChartTwo.snp.left).offset(0)
            make.right.equalTo(lineChartTwo.snp.right).offset(0)
            make.top.equalTo(columnarLabel.snp.bottom).offset(10)
            make.height.equalTo(lineChartTwo.snp.height)
        }
        
        //饼状图
        let cakeLabel = UILabel()
        cakeLabel.text = "饼状图"
        cakeLabel.font = UIFont.systemFont(ofSize: 16)
        cakeLabel.textAlignment = NSTextAlignment.center
        self.scrollView.addSubview(cakeLabel)
        cakeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(columnarLabel.snp.left).offset(0)
            make.right.equalTo(columnarLabel.snp.right).offset(0)
            make.top.equalTo(bar.snp.bottom).offset(10)
            make.height.equalTo(columnarLabel.snp.height)
        }
        
        let item1 = ShinePieItem.init(color: .red, value: 0.7,title: "redcolor")
        let item2 = ShinePieItem.init(color: .blue, value: 0.2,title: "bluecolor")
        let item3 = ShinePieItem.init(color: .purple, value: 0.3,title: "purplecolor")
        let pie = ShinePieChart.init(frame: CGRect.zero, items: [item1,item2,item3])
        pie.ringRadius = 20
        pie.startAngle = 0.2
        pie.font = UIFont.systemFont(ofSize: 12)
        pie.duration = 1.5
        self.scrollView.addSubview(pie)
        pie.snp.makeConstraints { (make) in
            make.left.equalTo(bar.snp.left).offset(0)
            make.right.equalTo(bar.snp.right).offset(0)
            make.top.equalTo(cakeLabel.snp.bottom).offset(10)
            make.height.equalTo(bar.snp.height)
        }
        
        self.scrollView.contentSize = CGSize(width: 0, height: 1000)
        
    }
    

    

}
