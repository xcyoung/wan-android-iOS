//
//  TreeListViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/3.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import MyLayout
class TreeListViewController: PageTableViewController {
    private let treeViewModel = TreeViewModel.init()

    private var treeList: [TreeListModel] = []
    private var treeSelectedIndexPath: IndexPath? = nil {
        didSet {
            self.refreshing(isBegin: true)
        }
    }
    private var lastSelectedTreeTime: TimeInterval = 0
    private let treeTableView: UITableView = {
        let tableView = UITableView.init()
        tableView.separatorStyle = .singleLine
        tableView.register(TreeListItemCell.self, forCellReuseIdentifier: TreeListItemCell.description())
        tableView.register(TreeListHeaderView.self, forHeaderFooterViewReuseIdentifier: TreeListHeaderView.description())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        treeViewModel.treeListLiveData.asObservable().subscribe { [weak self] (event) in
            guard let list = event.element,
                let weakSelf = self
                else {
                    return
            }
            weakSelf.treeList.removeAll()
            weakSelf.treeList.append(contentsOf: list)
            weakSelf.treeTableView.reloadData()

            weakSelf.treeSelectedIndexPath = IndexPath.init(row: 0, section: 0)
            weakSelf.treeTableView.selectRow(at: weakSelf.treeSelectedIndexPath, animated: false, scrollPosition: .middle)
        }.disposed(by: disposeBag)

        treeViewModel.treeSubListLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }

            self?.onLoadSuccess(result: model)
        }.disposed(by: disposeBag)

        treeViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }

            self?.onLoadFail(error)
        }.disposed(by: disposeBag)
        
        treeViewModel.treeList()
    }

    override func initView() {
        super.initView()

        let layout = MyFlexLayout.init()
        layout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        layout.isFlex = true

        treeTableView.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.fill())
        treeTableView.myFlex.attrs.flex_grow = 2
        tableView.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.fill())
        tableView.myFlex.attrs.flex_grow = 3

        layout.addSubview(treeTableView)
        layout.addSubview(tableView)

        self.parentView.addSubview(layout)

        treeTableView.delegate = self
        treeTableView.dataSource = self
    }

    override func configTableView() {
        super.configTableView()

        self.tableView.separatorInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.tableView.register(ArticleListItemCell.self, forCellReuseIdentifier: ArticleListItemCell.description())
    }

    override func getRefresh() -> MJRefreshHeader? {
        return MJRefreshStateHeader.init()
    }

    override func getFooter() -> MJRefreshFooter? {
        return MJRefreshBackStateFooter.init()
    }

    override func getStrategy() -> PageStrategy? {
        return WanAndroidPageStrategy.init(pageStartNum: 0, pageSize: 20)
    }

    override func onLoadData(page: PageStrategy?) {
        guard let selectedIndexPath = treeSelectedIndexPath,
            let wanPage = page as? WanAndroidPageStrategy,
            let wanPageInfo = wanPage.pageInfo as? WanAnroidNumPageInfo else {
                return
        }

        let cId = treeList[selectedIndexPath.section].children[selectedIndexPath.row].id
        treeViewModel.treeSubList(pageIndex: wanPageInfo.pageNum, id: cId)
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

extension TreeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == treeTableView {
            return self.treeList.count
        }
        return super.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == treeTableView {
            return self.treeList[section].children.count
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == treeTableView {
            if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TreeListHeaderView.description()) as? TreeListHeaderView {
                view.setModel(item: self.treeList[section])
                return view
            }
            return nil
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == treeTableView {
            let model = self.treeList[indexPath.section].children[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: TreeListItemCell.description()) as? TreeListItemCell {
                cell.setModel(item: model)
                return cell
            }
        } else if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem,
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListItemCell.description()) as? ArticleListItemCell {
            cell.setModel(item: model)
            return cell
        }
        return UITableViewCell.init()
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView == treeTableView,
            self.treeSelectedIndexPath?.section != indexPath.section || self.treeSelectedIndexPath?.row != indexPath.row {
            if Date().timeIntervalSince1970 - lastSelectedTreeTime > 3 {
                self.lastSelectedTreeTime = Date().timeIntervalSince1970
                return indexPath
            } else {
                // MARK: - 双列表交互，不想接口响应太频繁
                toast(message: "不能切换太频繁，3s后重试")
                return nil
            }
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == treeTableView,
            self.treeSelectedIndexPath?.section != indexPath.section || self.treeSelectedIndexPath?.row != indexPath.row {
            self.treeSelectedIndexPath = indexPath
        } else {
            guard let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem
                else {
                    return
            }

            BrowserViewController.jump(vc: self, url: model.link)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == treeTableView {
            return 50
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == treeTableView {
            return 45
        } else {
            return 150
        }
    }
}
