//
//  HomeViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class HomeViewController: BaseViewController {
    private let tabBar: UITabBar = {
        var items = [UITabBarItem]()
        let tabItem = UITabBarItem.init()
        tabItem.title = "首页"
        items.append(tabItem)

        let tabItem2 = UITabBarItem.init()
        tabItem2.title = "体系"
        items.append(tabItem2)

        let tabBar = UITabBar.init()
        tabBar.setItems(items, animated: true)
        tabBar.barTintColor = UIColor.systemGreen
        tabBar.tintColor = UIColor.white
        tabBar.isTranslucent = false
//        tabBar.
        return tabBar
    }()

    private let contentView: UIView = UIView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initView() {
        super.initView()

        let layout = MyFlexLayout.init()
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.isFlex = true
        layout.myFlex.attrs.flex_direction = MyFlexDirection_Column

        self.tabBar.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        self.tabBar.myFlex.attrs.flex_grow = 1
        self.contentView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        self.contentView.myFlex.attrs.flex_grow = 2
        layout.addSubview(self.contentView)
        layout.addSubview(self.tabBar)
        self.parentView.addSubview(layout)
//        self.tabBar.frame = CGRect(x:0, y:self.view.frame.height - 50,
//        width:self.view.frame.width, height:50)
//        self.view.addSubview(self.tabBar)
        self.tabBar.tintColor = UIColor.white
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    }
}
