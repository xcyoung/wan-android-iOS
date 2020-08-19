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
        RouterCenter.shared.goToBrowser(url: url)
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

    private let progressView: UIView = {
        let progress = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 2))
        progress.backgroundColor = UIColor.project.primary
        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let url = URL(string: self.url) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }

    override func initView() {
        super.initView()

        self.parentView.addSubview(webView)
        self.parentView.addSubview(progressView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.webView.removeObserver(self, forKeyPath: "title")
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            self.title = self.webView.title
        } else if keyPath == "estimatedProgress" {
            let progress = self.webView.estimatedProgress
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                let width = self?.webView.frame.width ?? 0
                self?.progressView.frame = CGRect.init(x: 0, y: 0, width: width * CGFloat.init(progress), height: 2)
            }) { [weak self] (finish) in
                if progress >= 0.99 {
                    self?.progressView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 2)
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
