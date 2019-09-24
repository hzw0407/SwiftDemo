//
//  Config.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/13.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

// 屏幕宽
let ScreenWidth = UIScreen.main.bounds.size.width
// 屏幕高
let ScreenHeight = UIScreen.main.bounds.size.height
//是否是iPhoneX
let isiPhoneX = ScreenWidth == 812
//导航栏高度
let TopNaviHeight: CGFloat = isiPhoneX ? 88 : 64
//工具栏高度
let tabBarHeight: CGFloat = isiPhoneX ? 34 + 49 : 49
//状态栏高度
let StatusBarHeight: CGFloat = isiPhoneX ? 44 : 20

let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)

//高德地图key
let GDMapKey = "10af04b9af8fdcfd19952c6b0dc1a6c7"

class Config: NSObject {

}
