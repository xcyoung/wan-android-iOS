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
        window.rootViewController = UINavigationController.init(rootViewController: TreeListViewController.init())
        
        UINavigationBar.appearance().tintColor = UIColor.systemGreen //前景色，按钮颜色
        UINavigationBar.appearance().barTintColor = UIColor.white //背景色，导航条背景色
        UINavigationBar.appearance().isTranslucent = true // 导航条背景是否透明
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)] // 设置导航条标题颜色，还可以设置其它文字属性，只需要在里面添加对应的属性
        
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        print("AppDelegate:\(window)")
        return true
    }
}

