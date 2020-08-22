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
import Lottie
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

        articleViewModel.collectionArticleLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element,
                let index = self?.dataSource[0].firstIndex(where: { ($0 as? ArticleItem)?.id == model.id }),
                index < (self?.dataSource[0].count ?? 0),
                let item = self?.dataSource[0][index] as? ArticleItem
                else {
                    return
            }

            if model.isSuccess {
                item.zan = 1
            } else {
                item.zan = 0
                if let cell = self?.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as? ArticleListItemCell {
                    cell.updateLikeState(isLike: false, animated: true)
                }
                self?.goToAccount()
            }

        }.disposed(by: self.disposeBag)

        articleViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }

            self?.onLoadFail(error)
        }.disposed(by: self.disposeBag)

        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func initView() {
        super.initView()
        self.tableView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.parentView.addSubview(tableView)
    }

    override func getStrategy() -> PageStrategy? {
        return WanAndroidPageStrategy.init(pageStartNum: 0, pageSize: 20)
    }

    override func configTableView() {
        super.configTableView()

//        self.tableView.separatorInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        self.tableView.register(ArticleListItemCell.self, forCellReuseIdentifier: ArticleListItemCell.description())
        self.tableView.register(ArticleBanner.self, forCellReuseIdentifier: ArticleBanner.description())
    }

    override func getRefresh() -> MJRefreshHeader? {
        return MJRefreshNormalHeader.init()
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem,
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListItemCell.description()) as? ArticleListItemCell {
            cell.setModel(item: model)
            cell.addRecognizerToLikeBtn(onLikeBtnClick(_:), index: indexPath.row)
            return cell
        } else if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleBannerModel, let cell = tableView.dequeueReusableCell(withIdentifier: ArticleBanner.description()) as? ArticleBanner {
            cell.setItems(banners: model.banners)
            return cell
        } else {
            return UITableViewCell.init()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem
            else {
                return
        }

        BrowserViewController.jump(vc: self, url: model.link)
    }

    @objc private func onLikeBtnClick(_ index: Int) {
        if index < dataSource[0].count,
            let model = dataSource[0][index] as? ArticleItem {
            if model.zan == 1 {
//                model.zan = 0
            } else {
                articleViewModel.collectionInside(id: model.id)
            }
        }
    }
    
    private func goToAccount() {
        let accountViewController = AccountViewController.init()
        let accountNavigationVC = UINavigationController.init(rootViewController: accountViewController)
//        accountNavigationVC.navigationBar.barStyle = .blackTranslucent
        accountNavigationVC.modalPresentationStyle = .fullScreen
        self.present(accountNavigationVC, animated: true, completion: nil)
    }
}
