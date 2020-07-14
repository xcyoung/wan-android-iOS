//
//  AppDelegate.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/18.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = ArticleViewController.init()
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        print("AppDelegate:\(window)")
        return true
    }
}

