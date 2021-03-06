//
//  OfficialViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/8.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
import MJRefresh
import XLPagerTabStrip
class ProjectListViewController: PageTableViewController {
    var projectViewModel: ProjectViewModel?

    var model: ProjectListModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        projectViewModel?.projectListLiveData.asObservable().subscribe({ [weak self] (event) in
            guard let model = event.element,
                let weakSelf = self else {
                    return
            }

            weakSelf.onLoadSuccess(result: model)
        }).disposed(by: disposeBag)

        projectViewModel?.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }
            
            if self?.pageStrategy?.pageInfo.isFirstPage() == true {
                self?.showError(error: error)
            } else {
                self?.toastError(error: error)
            }
        }.disposed(by: disposeBag)
        
        loadData()
    }

    override func initView() {
        super.initView()

        let layout = MyFlexLayout.init()
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.isFlex = true

        tableView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        layout.addSubview(tableView)

        self.parentView.addSubview(layout)
    }

    override func configTableView() {
        super.configTableView()

        self.tableView.separatorStyle = .none
        self.tableView.register(ArticleListItemCell.self, forCellReuseIdentifier: ArticleListItemCell.description())
    }

    override func getRefresh() -> MJRefreshHeader? {
        return MJRefreshNormalHeader.init()
    }

    override func getFooter() -> MJRefreshFooter? {
        return MJRefreshBackStateFooter.init()
    }

    override func getStrategy() -> PageStrategy? {
        return WanAndroidPageStrategy.init(pageStartNum: 0, pageSize: 20)
    }

    override func onLoadData(page: PageStrategy?) {
        guard let id = model?.id,
            let wanPage = page as? WanAndroidPageStrategy,
            let wanPageInfo = wanPage.pageInfo as? WanAnroidNumPageInfo else {
                return
        }

        projectViewModel?.projectList(id: id, pageIndex: wanPageInfo.pageNum)
    }

    override func transformDataSource(result: Any?) {
        if let listModel = result as? ArticleListModel {
            let contentItems = listModel.datas

            if pageStrategy?.pageInfo.isFirstPage() == true {
                self.dataSource.removeAll()
            }
            self.dataSource.append(contentItems)
        }
    }

}

extension ProjectListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem,
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListItemCell.description()) as? ArticleListItemCell {
            cell.setModel(item: model)
            return cell
        }
        return UITableViewCell.init()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem
            else {
                return
        }

        BrowserViewController.jump(vc: self, url: model.link)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
}

extension ProjectListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: model?.name)
    }
}
