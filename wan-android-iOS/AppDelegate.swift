//
//  AppDelegate.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/18.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
#if DEBUG
    import DoraemonKit
#endif
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let wanNavigationDelegate = WanNavigationDelegate.init()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
            DoraemonManager.shareInstance().install()
            DoraemonManager.shareInstance().showDoraemon()
        #endif

        RouterCenter.shared.initialize()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        let window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController.init(rootViewController: HomeViewController.init())
        navigationController.delegate = self
        window.rootViewController = navigationController

        UINavigationBar.appearance().tintColor = UIColor.project.text//前景色，按钮颜色
        UINavigationBar.appearance().barTintColor = UIColor.project.background //背景色，导航条背景色
        UINavigationBar.appearance().isTranslucent = true // 导航条背景是否透明
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.project.text, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)] // 设置导航条标题颜色，还可以设置其它文字属性，只需要在里面添加对应的属性

        UITabBarItem.appearance().setTitleTextAttributes([
                .strokeColor: UIColor.gray,
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14)
            ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([
                .strokeColor: UIColor.project.primary,
                .foregroundColor: UIColor.project.primary,
                .font: UIFont.systemFont(ofSize: 16)
            ], for: .selected)
        window.backgroundColor = UIColor.project.appBackground
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

extension AppDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return wanNavigationDelegate.navigationController(
            navigationController,
            animationControllerFor: operation,
            from: fromVC,
            to: toVC)
    }
}
