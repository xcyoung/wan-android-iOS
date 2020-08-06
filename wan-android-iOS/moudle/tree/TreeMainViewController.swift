//
//  TreeMainViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class TreeMainViewController: BaseViewController {
    private let toolbar: MyLinearLayout = {
        let bar = MyLinearLayout.init()

        return bar
    }()

    private let segment: UISegmentedControl = {
        let items = ["体系", "导航"]
        let segment = UISegmentedControl.init(items: items)

        segment.selectedSegmentIndex = 0
        
        return segment
    }()

    private let treeListViewController: TreeListViewController = TreeListViewController.init()

    private let naviListViewController: NaviListViewController = NaviListViewController.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.segment.addTarget(self, action: #selector(onSegmentValueChange(sender:)), for: .valueChanged)
    }

    override func initView() {
        super.initView()

        let layout = MyLinearLayout.init()
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.toolbar.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 44)
        self.toolbar.gravity = MyGravity_Center

        self.segment.mySize = CGSize.init(width: UIScreen.main.bounds.width / 2, height: CGFloat.init(MyLayoutSize.wrap()))


        self.treeListViewController.view.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        self.naviListViewController.view.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.toolbar.addSubview(self.segment)
        layout.addSubview(self.toolbar)
        addChild(self.treeListViewController)
        addChild(self.naviListViewController)
        layout.addSubview(self.treeListViewController.view)
        layout.addSubview(self.naviListViewController.view)
        self.parentView.addSubview(layout)

        self.treeListViewController.view.isHidden = false
        self.naviListViewController.view.isHidden = true
    }

    override func setNavigationBarHidden() {
        self.setNavigationBarHiddenForSubVC()
    }

    @objc private func onSegmentValueChange(sender: UISegmentedControl) {
        self.treeListViewController.view.isHidden = sender.selectedSegmentIndex != 0
        self.naviListViewController.view.isHidden = sender.selectedSegmentIndex == 0
    }
}
