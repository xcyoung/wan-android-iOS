//
//  ArticleMainViewController.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/3.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class ArticleMainViewController: BaseViewController {

    private let searchBar: MyFrameLayout = {
        let view = MyFrameLayout.init()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.myVertMargin = CGFloat.init(4)
        view.myHorzMargin = CGFloat.init(8)
        return view
    }()

    private let searchTips: UILabel = {
        let label = UILabel.init()
        label.text = "搜索"
        label.textAlignment = .center
        label.textColor = UIColor.gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(hex6: 0xf9f9f9, alpha: 1)
    }

    override func initView() {
        super.initView()
        
        let layout = MyLinearLayout.init()
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.searchBar.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 35)
        self.searchBar.gravity = MyGravity_Center
        
        let articleViewController = ArticleViewController.init()
        articleViewController.view.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.addSubview(self.searchBar)
        layout.addSubview(articleViewController.view)
        self.parentView.addSubview(layout)
        addChild(articleViewController)
        
        self.searchTips.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.wrap())
        self.searchBar.addSubview(self.searchTips)
    }
    
    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}
