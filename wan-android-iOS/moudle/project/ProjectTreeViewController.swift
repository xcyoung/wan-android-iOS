//
//  OfficialChapterViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/8.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import MyLayout

class ProjectTreeViewController: BaseViewController {
    private let projectViewModel = ProjectViewModel.init()

    private var tree = [ProjectListModel]()

    private let pagerTabStrip: ButtonBarPagerTabStripViewController = {
        let vc = ButtonBarPagerTabStripViewController()
        vc.pagerBehaviour = PagerTabStripBehaviour.progressive(skipIntermediateViewControllers: true,
            elasticIndicatorLimit: true)

        vc.automaticallyAdjustsScrollViewInsets = false
        vc.settings.style.buttonBarBackgroundColor = UIColor.clear

        vc.settings.style.buttonBarLeftContentInset = 0
        vc.settings.style.buttonBarRightContentInset = 0

        vc.settings.style.selectedBarBackgroundColor = UIColor.systemGreen
        vc.settings.style.selectedBarHeight = 3
        
        vc.settings.style.buttonBarItemFont = UIFont.boldSystemFont(ofSize: 15)
        vc.settings.style.buttonBarItemLeftRightMargin = 4
        vc.settings.style.buttonBarItemBackgroundColor = UIColor.clear
        vc.settings.style.buttonBarItemTitleColor = UIColor.systemGreen
        vc.settings.style.buttonBarItemsShouldFillAvailiableWidth = false

        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        projectViewModel.projectTreeLiveData.asObservable().subscribe { [weak self] (event) in
            guard let list = event.element else {
                return
            }

            self?.tree.removeAll()
            self?.tree.append(contentsOf: list)
            self?.updatePager()
        }.disposed(by: disposeBag)


        projectViewModel.projectTreeList()
    }

    override func initView() {
        super.initView()

        pagerTabStrip.datasource = self

        pagerTabStrip.changeCurrentIndexProgressive = {
            (oldCell: ButtonBarViewCell?,
                newCell: ButtonBarViewCell?,
                progressPercentage: CGFloat,
                changeCurrentIndex: Bool,
                animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = UIColor.gray
            newCell?.label.textColor = UIColor.systemGreen
        }
    }

    func updatePager() {
        pagerTabStrip.willMove(toParent: self)
//        self.pagerTabStrip.view.mySize
        self.parentView.addSubview(pagerTabStrip.view)
        self.addChild(pagerTabStrip)
        pagerTabStrip.didMove(toParent: self)
    }
    
    override func setNavigationBarHidden() {
        self.setNavigationBarHiddenForSubVC()
    }
}

extension ProjectTreeViewController: PagerTabStripDataSource {
    func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let viewControllers = self.tree.map { (model) -> UIViewController in
            let vc = ProjectListViewController.init()
            vc.projectViewModel = projectViewModel
            vc.model = model
            return vc
        }
        return viewControllers
    }
}
