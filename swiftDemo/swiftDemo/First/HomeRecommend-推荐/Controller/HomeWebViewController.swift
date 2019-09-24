//
//  HomeWebViewController.swift
//  swiftDemo
//
//  Created by HZW on 2019/3/13.
//  Copyright © 2019年 HZW. All rights reserved.
//

import UIKit
import WebKit

class HomeWebViewController: UIViewController {

    private var url:String = ""
    public var titleStr: String?
    
    convenience init(url:String = "") {
        self.init()
        self.url = url
    }
    
    lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.titleStr
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
        
    }

}
