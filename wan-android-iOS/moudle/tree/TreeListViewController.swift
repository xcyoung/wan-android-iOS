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
    private var treeSelectedIndexPath: IndexPath = IndexPath.init(row: 0, section: 0)
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
            weakSelf.treeTableView.selectRow(at: weakSelf.treeSelectedIndexPath, animated: false, scrollPosition: .middle)
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
    }

    override func getRefresh() -> MJRefreshHeader? {
        return MJRefreshStateHeader.init()
    }

    override func getFooter() -> MJRefreshFooter? {
        return MJRefreshBackStateFooter.init()
    }
}

extension TreeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == treeTableView {
            return self.treeList.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == treeTableView {
            return self.treeList[section].children.count
        }
        return 0
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
        }
        return UITableViewCell.init()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == treeTableView,
            self.treeSelectedIndexPath.section != indexPath.section && self.treeSelectedIndexPath.row != indexPath.row {
            self.treeSelectedIndexPath = indexPath
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == treeTableView {
            return 50
        } else {
            return 0
        }
    }
}
