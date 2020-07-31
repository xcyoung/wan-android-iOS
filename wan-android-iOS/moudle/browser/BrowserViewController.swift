//
//  BrowserViewController.swift
//  wan-android-iOS
//
//  Created by idt on 2020/7/31.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import MyLayout
class BrowserViewController: BaseViewController {
    class func jump(vc: UIViewController, url: String) {
        let target = BrowserViewController.init()
        target.params["url"] = url
        vc.navigationController?.pushViewController(target, animated: true)
    }

    private var url: String {
        get {
            let url = self.params["url"] as? String ?? ""
            return url
        }
    }

    private let webView: WKWebView = {
        let webView = WKWebView.init()
        webView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: self.url)
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }

    override func initView() {
        super.initView()

        let view = MyFlexLayout.init()
        view.myHeight = CGFloat.init(MyLayoutSize.fill())
        view.myWidth = CGFloat.init(MyLayoutSize.fill())
        
        view.addSubview(webView)
        
        self.view.addSubview(view)
    }
}
