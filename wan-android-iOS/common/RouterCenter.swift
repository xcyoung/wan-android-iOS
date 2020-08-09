//
//  RouterCenter.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/9.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import URLNavigator

class RouterCenter: NSObject {
    public static let shared: RouterCenter = RouterCenter.init()

    private let navigator = Navigator()

    enum Path: String, CaseIterable {
        case browser = "/browser"

        func absolutePath() -> String {
            return "xWanAndroid://me.xcyoung.com" + self.rawValue
        }
    }

    override init() {

    }

    func initialize() {
        Path.allCases.forEach { (path) in
            self.register(path: path.absolutePath())
            self.handle(path: path.absolutePath())
        }
    }

    func register(path: String) {
        navigator.register(path) { (url, value, context) -> UIViewController? in
            return self.onRegister(url: url.urlValue, urlString: url.urlStringValue, queryParameters: url.queryParameters, values: value, context: context)
        }
    }

    func handle(path: String) {
        navigator.handle(path) { (url, value, context) -> Bool in
            return self.onHandle(url: url.urlValue, urlString: url.urlStringValue, queryParameters: url.queryParameters, values: value, context: context)
        }
    }

    func onRegister(url: URL?, urlString: String, queryParameters: [String: String], values: [String: Any], context: Any?) -> UIViewController? {
        switch url?.path {
        case Path.browser.rawValue:
            let target = BrowserViewController.init()
            let paramUrl = queryParameters["url"]
            target.params["url"] = paramUrl
            return target
        default:
            return nil
        }
    }

    func onHandle(url: URL?, urlString: String, queryParameters: [String: String], values: [String: Any], context: Any?) -> Bool {
        return true
    }

    func goToBrowser(url: String) {
        navigator.push("\(Path.browser.absolutePath())?url=\(url)")
    }
}
