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
        let titles = ["首页", "体系", "公众号"]
        for i in 0...2 {
            let tabItem = UITabBarItem.init()
            tabItem.title = titles[i]
            tabItem.tag = i
            items.append(tabItem)
        }

        let tabBar = UITabBar.init()
        tabBar.setItems(items, animated: true)
        tabBar.barTintColor = UIColor.white
//        tabBar.tintColor = UIColor.white
        tabBar.isTranslucent = false
        
        tabBar.selectedItem = items[0]
        return tabBar
    }()

    private let contentView: UIView = UIView.init()

    private let article = ArticleMainViewController.init()
    private let tree = TreeMainViewController.init()
    private let official = OfficialChapterViewController.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
    }

    override func initView() {
        super.initView()
        
        self.contentView.frame = CGRect.init(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height - 50 - 20)
        self.tabBar.frame = CGRect.init(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50)

        self.view.addSubview(self.contentView)
        self.view.addSubview(self.tabBar)
        
        self.article.view.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        self.tree.view.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        self.official.view.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        
        addChild(article)
        addChild(tree)
        addChild(official)
        self.contentView.addSubview(self.article.view)
        self.contentView.addSubview(self.tree.view)
        self.contentView.addSubview(self.official.view)
        self.article.view.isHidden = false
        self.tree.view.isHidden = true
        self.official.view.isHidden = true
    }
    
    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            self.article.view.isHidden = false
            self.tree.view.isHidden = true
            self.official.view.isHidden = true
            break
        case 1:
            self.article.view.isHidden = true
            self.tree.view.isHidden = false
            self.official.view.isHidden = true
            break
        case 2:
            self.article.view.isHidden = true
            self.tree.view.isHidden = true
            self.official.view.isHidden = false
            break
        default:
            self.article.view.isHidden = true
            self.tree.view.isHidden = true
            self.official.view.isHidden = true
        }
    }
}
