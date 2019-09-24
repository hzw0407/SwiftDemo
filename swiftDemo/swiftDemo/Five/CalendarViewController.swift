//
//  CalendarViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/12/20.
//  Copyright © 2018年 HZW. All rights reserved.
//  --日历

import UIKit
import CVCalendar

class CalendarViewController: UIViewController {

    //星期菜单栏
    private var menuView: CVCalendarMenuView!
    //日历主视图
    private var calendarView: CVCalendarView!
    var currentCalendar: Calendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        //初始化设置为中国
        currentCalendar = Calendar.init(identifier: .chinese)

        //初始化的时候导航栏显示当年当月
        self.title = CVDate(date: Date(), calendar: currentCalendar).globalDescription

        //初始化星期菜单栏
        self.menuView = CVCalendarMenuView.init()
        self.menuView.menuViewDelegate = self
        self.view.addSubview(self.menuView)
        self.menuView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(TopNaviHeight)
            make.height.equalTo(15)
        }

        //初始化日历主视图
        self.calendarView = CVCalendarView.init()
        self.calendarView.calendarDelegate = self
        self.view.addSubview(self.calendarView)
        self.calendarView.snp.makeConstraints { (make) in
            make.left.equalTo(self.menuView.snp_leftMargin).offset(0)
            make.right.equalTo(self.menuView.snp_rightMargin).offset(0)
            make.top.equalTo(self.menuView.snp_bottomMargin).offset(15)
            make.height.equalTo(450)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //更新日历frame
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.calendarView = nil
        self.menuView = nil
    }

}

extension CalendarViewController: CVCalendarViewDelegate,CVCalendarMenuViewDelegate {
    //星期栏文字显示类型
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }

    //视图模式
    func presentationMode() -> CalendarMode {
        //使用月视图
        return .monthView
    }

    //每周的第一天
    func firstWeekday() -> Weekday {
        //从星期一开始
        return .monday
    }

    //是否显示非当月的日期
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }

    //滑动切换月份
    func presentedDateUpdated(_ date: CVDate) {
        //导航栏显示当前日历的年月
        self.title = date.globalDescription
    }

    //每个日期上面是否添加横线(连在一起就形成每行的分隔线)
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }

    //切换月的时候日历是否自动选择某一天（本月为今天，其它月为第一天）
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }

    //日期选择响应
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        //获取日期
        let date = dayView.date.convertedDate()!
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let message = "当前选择的日期是：\(dformatter.string(from: date))"
        //将选择的日期弹出显示
        let alertController = UIAlertController(title: "", message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
