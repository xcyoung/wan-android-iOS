//
//  BaseTableViewUIController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/28.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
class BaseTableViewController: BaseViewController {
    public let tableView: UITableView = UITableView.init(frame: CGRect.zero)

    public var header: MJRefreshHeader?
    public var footer: MJRefreshFooter?

    //  MARK: - 模版，用于设置自定义的header、footer
    open func getRefresh() -> MJRefreshHeader? {
        return nil
    }
    
    open func getFooter() -> MJRefreshFooter? {
        return nil
    }
    
    open func configRefresh() {
        header = self.getRefresh()
        footer = self.getFooter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initView() {
        super.initView()
        configRefresh()
        
        self.parentView.addSubview(tableView)
        
        configTableView()
    }

    //  MARK: - 子类需实现该方法配置tableView
    public func configTableView() {
        tableView.mj_header = self.header
        tableView.mj_footer = self.footer

        tableView.mj_footer?.isHidden = true
        tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(self.onRefresh))
        tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(self.onLoadMore))
    }

    @objc func onRefresh() {
        footer?.isHidden = true
        refresh()
    }

    @objc func onLoadMore() {
        load()
    }

    // MARK: - 子类实现refresh与load加载数据
    open func refresh() {

    }

    open func load() {

    }

    public func refreshing(isBegin: Bool) {
        if isBegin {
            if header?.isRefreshing == false {
                header?.beginRefreshing()
            }
        } else {
            if header?.isRefreshing == true {
                header?.endRefreshing()
            }
        }
    }

    public func loading(isBegin: Bool) {
        if isBegin {
            if footer?.isRefreshing == false {
                footer?.beginRefreshing()
            }
        } else {
            if footer?.isRefreshing == true {
                footer?.endRefreshing()
            }
        }
    }
    
    public func setLoadMoreEnable(b: Bool) {
        tableView.mj_footer?.isHidden = !b
    }
    public func setRefreshEnable(b: Bool) {
        tableView.mj_header?.isHidden = !b
    }
}

//extension BaseTableViewUIController: UITableViewDataSource, UITableViewDelegate {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////    }
//    
//    
//}
