//
//  TabBarController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/14.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var items: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //工具栏背景颜色
        self.tabBar.barTintColor = UIColor(red: 211 / 255.0, green: 211 / 255.0, blue: 211 / 255.0, alpha: 1.0)
        
        let first: FirstViewController = FirstViewController()
        let rootNavOne = UINavigationController(rootViewController: first)
        rootNavOne.tabBarItem.title = "1"
        var normalIMageOne = UIImage(named: "firstNormal")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是灰色
        normalIMageOne = normalIMageOne!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavOne.tabBarItem.image = normalIMageOne
        var selectImageOne = UIImage(named: "firstSelect")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是蓝色
        selectImageOne = selectImageOne!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavOne.tabBarItem.selectedImage = selectImageOne
        
        let second: SecondViewController = SecondViewController()
        let rootNavTwo = UINavigationController(rootViewController: second)
        rootNavTwo.tabBarItem.title = "2"
        var normalIMageTwo = UIImage(named: "secondNormal")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是灰色
        normalIMageTwo = normalIMageTwo!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavTwo.tabBarItem.image = normalIMageTwo
        var selectImageTwo = UIImage(named: "secondSelect")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是蓝色
        selectImageTwo = selectImageTwo!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavTwo.tabBarItem.selectedImage = selectImageTwo
        
        let three: ThreeViewController = ThreeViewController()
        let rootNavThree = UINavigationController(rootViewController: three)
        rootNavThree.tabBarItem.title = "3"
        var normalIMageThree = UIImage(named: "threeNormal")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是灰色
        normalIMageThree = normalIMageThree!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavThree.tabBarItem.image = normalIMageThree
        var selectImageThree = UIImage(named: "threeSelect")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是蓝色
        selectImageThree = selectImageThree!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavThree.tabBarItem.selectedImage = selectImageThree
        
        let four: FourViewController = FourViewController()
        let rootNavFour = UINavigationController(rootViewController: four)
        rootNavFour.tabBarItem.title = "4"
        var normalIMageFour = UIImage(named: "fourNormal")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是灰色
        normalIMageFour = normalIMageFour!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavFour.tabBarItem.image = normalIMageFour
        var selectImageFour = UIImage(named: "fourSelect")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是蓝色
        selectImageFour = selectImageFour!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavFour.tabBarItem.selectedImage = selectImageFour
        
        let five: FiveViewController = FiveViewController()
        let rootNavFive = UINavigationController(rootViewController: five)
        rootNavFive.tabBarItem.title = "5"
        var normalIMageFive = UIImage(named: "fiveNormal")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是灰色
        normalIMageFive = normalIMageFive!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavFive.tabBarItem.image = normalIMageFive
        var selectImageFive = UIImage(named: "fiveSelect")
        //始终绘制图片原始状态，不使用Tint Color 不然绘制出来的会是蓝色
        selectImageFive = selectImageFive!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootNavFive.tabBarItem.selectedImage = selectImageFive
        
        items = [rootNavOne,rootNavTwo,rootNavThree,rootNavFour,rootNavFive]
        self.viewControllers = items as? [UIViewController]
        //工具栏上文字选中和未选中颜色
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.white, forKey:NSAttributedString.Key.foregroundColor as NSCopying) as? [NSAttributedString.Key : Any], for:UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(object:UIColor.red, forKey:NSAttributedString.Key.foregroundColor as NSCopying) as? [NSAttributedString.Key : Any], for:UIControl.State.selected)
        
    }

}
