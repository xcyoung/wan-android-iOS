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
        let titles = ["首页", "体系", "公众号", "项目"]
        let images = [R.image.wan_ic_home(),
            R.image.wan_ic_tree(),
            R.image.wan_ic_official(),
            R.image.wan_ic_project()]
        for i in 0...3 {
            let tabItem = UITabBarItem.init()
            tabItem.title = titles[i]
            tabItem.image = images[i]
            tabItem.tag = i
            items.append(tabItem)
        }

        let tabBar = UITabBar.init()
        tabBar.setItems(items, animated: true)
        tabBar.barTintColor = UIColor.project.appBar
        tabBar.tintColor = UIColor.project.primary
        tabBar.isTranslucent = false

        tabBar.selectedItem = items[0]
        return tabBar
    }()

    private let contentView: UIView = UIView.init()

    private var subVCMap: [Int: BaseViewController] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
    }

    override func initView() {
        super.initView()

        let layout = MyLinearLayout.init()
        layout.orientation = MyOrientation_Vert
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.contentView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        self.contentView.weight = 2
        self.tabBar.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 50)

        layout.addSubview(self.contentView)
        layout.addSubview(self.tabBar)
        self.parentView.addSubview(layout)
        self.showSubViewController(index: 0)
    }

    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        showSubViewController(index: item.tag)
    }

    func showSubViewController(index: Int) {
        if self.subVCMap[index] == nil {
            let vc: BaseViewController
            switch index {
            case 0:
                vc = ArticleMainViewController.init()
                break
            case 1:
                vc = TreeMainViewController.init()
                break
            case 2:
                vc = OfficialChapterViewController.init()
                break
            default:
                vc = ProjectTreeViewController.init()
                break
            }
            vc.view.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
            self.contentView.addSubview(vc.view)
            vc.beginAppearanceTransition(true, animated: true)
            subVCMap[index] = vc
        }
        subVCMap.forEach { (key: Int, value: BaseViewController) in
            if key == index {
                value.view.isHidden = false
            } else {
                value.view.isHidden = true
            }
        }
    }
}
