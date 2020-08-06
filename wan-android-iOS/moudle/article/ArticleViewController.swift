//
//  ArticleViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/7.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import MyLayout
class ArticleViewController: PageTableViewController {
    private let articleViewModel = ArticleViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articleViewModel.articleFirstListLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }

            self?.onLoadSuccess(result: model)
        }.disposed(by: self.disposeBag)

        articleViewModel.articleListLiveData.asObservable().subscribe { [weak self] event in
            guard let model = event.element else {
                return
            }

            self?.onLoadSuccess(result: model)
        }.disposed(by: self.disposeBag)
        
        articleViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }
            
            self?.onLoadFail(error)
        }.disposed(by: self.disposeBag)
        
        articleViewModel.onRefresh(pageIndex: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func initView() {
        super.initView()
        
//        let layout = MyLinearLayout.init()
//        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
//
//        self.searchBar.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 50)
        self.tableView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        
//        self.parentView.addSubview(searchBar)
        self.parentView.addSubview(tableView)
        
//        self.parentView.addSubview(layout)
    }

    override func getStrategy() -> PageStrategy? {
        return WanAndroidPageStrategy.init(pageStartNum: 0, pageSize: 20)
    }

    override func configTableView() {
        super.configTableView()

        self.tableView.separatorInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.tableView.register(ArticleListItemCell.self, forCellReuseIdentifier: ArticleListItemCell.description())
        self.tableView.register(ArticleBanner.self, forCellReuseIdentifier: ArticleBanner.description())
    }

    override func getRefresh() -> MJRefreshHeader? {
        return MJRefreshStateHeader.init()
    }

    override func getFooter() -> MJRefreshFooter? {
        return MJRefreshBackStateFooter.init()
    }

    override func onLoadData(page: PageStrategy?) {
        guard let wanPage = page as? WanAndroidPageStrategy,
            let wanPageInfo = wanPage.pageInfo as? WanAnroidNumPageInfo else {
                return
        }
        if wanPageInfo.isFirstPage() {
            articleViewModel.onRefresh(pageIndex: wanPageInfo.pageStartNum)
        } else {
            articleViewModel.onLoad(pageIndex: wanPageInfo.pageNum)
        }
    }

    override func transformDataSource(result: Any?) {
        if let firstModel = result as? ArticleFirstModel {
            var contentItems = [Any]()
            contentItems.append(firstModel.bannerModel)
            contentItems.append(contentsOf: firstModel.datas)
            
            self.dataSource.removeAll()
            self.dataSource.append(contentItems)
        } else if let listModel = result as? ArticleListModel {
            let contentItems = listModel.datas

            self.dataSource.append(contentItems)
        }
    }
    
    override func setNavigationBarHidden() {
        self.setNavigationBarHiddenForSubVC()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem,
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListItemCell.description()) as? ArticleListItemCell {
            cell.setModel(item: model)
            return cell
        } else if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleBannerModel, let cell = tableView.dequeueReusableCell(withIdentifier: ArticleBanner.description()) as? ArticleBanner {
            cell.setItems(banners: model.banners)
            return cell
        } else {
            return UITableViewCell.init()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem
            else {
                return
        }

        BrowserViewController.jump(vc: self, url: model.link)
    }
}
