//
//  FourViewController.swift
//  swiftDemo
//
//  Created by HZW on 2018/11/14.
//  Copyright © 2018年 HZW. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        self.title = "牛"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false;
    }

}
