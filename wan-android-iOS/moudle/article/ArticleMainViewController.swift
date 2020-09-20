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
        view.backgroundColor = UIColor.project.appBar
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
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onSearchBarClick(_:)))
        searchBar.addGestureRecognizer(tap)
    }

    @objc func getSearchBar() -> UIView {
        return searchBar
    }
    
    @objc private func onSearchBarClick(_ sender: UIGestureRecognizer) {
        RouterCenter.shared.goToSearch(fromVC: self)
    }
}
