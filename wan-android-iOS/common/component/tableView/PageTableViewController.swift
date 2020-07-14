//
//  PageTableViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/5.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class PageTableViewController: BaseTableViewController {
    public var pageStrategy: PageStrategy?
    public var dataSource = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.refreshing(isBegin: true)
    }
    
    override func initView() {
        super.initView()
        self.pageStrategy = getStrategy()
        
    }
    
    open func getStrategy() -> PageStrategy? {
        return nil
    }
    
    override func configTableView() {
        
    }
    
    override func refresh() {
        self.pageStrategy?.resetPage()
        loadData()
    }
    
    override func load() {
        loadData()
    }
    
    func loadData() {
        onLoadData(page: self.pageStrategy)
    }
    
    open func onLoadData(page: PageStrategy?) {
        
    }
    
    open func onLoadSuccess(result: Any?) {
        self.transformDataSource(result: result)
        if self.dataSource.isEmpty {
            showEmpty()
            return
        } else {
            showContent()
        }
        self.pageStrategy?.addPage(info: result)
        var listSize = 0
        dataSource.forEach { data in
            listSize += data.count
        }
        let isFinish = (self.pageStrategy?.checkFinish(result: result, listSize: listSize)) ?? false
        setLoadMoreEnable(b: !isFinish)
        self.tableView.reloadData()
    }
    
    open func transformDataSource(result: Any?) {
        
    }
    
    open func onLoadFail(_ error: XError? = nil){
        if(self.dataSource.count == 0) {
            showError()
        } else {
            if let e = error {
                self.toastError(error: e)
            } else {
                self.toast(message: "加载失败")
            }
        }
    }
}

extension PageTableViewController: UITableViewDataSource, UITableViewDelegate {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    // MARK:- 子类需要重写
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}
