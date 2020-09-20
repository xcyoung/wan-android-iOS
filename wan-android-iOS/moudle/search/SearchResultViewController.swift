//
//  SearchResultViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/20.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import MJRefresh
class SearchResultViewController: PageTableViewController {
    private let searchViewModel: SearchViewModel

    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchViewModel.onSearchLiveData.asObservable().subscribe { [weak self] (event) in
            self?.refreshing(isBegin: true)
        }.disposed(by: disposeBag)

        searchViewModel.searchResultLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }

            self?.onLoadSuccess(result: model)
        }.disposed(by: disposeBag)
        
        searchViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }

            self?.onLoadFail(error)
        }.disposed(by: self.disposeBag)
    }

    override func initView() {
        super.initView()

        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }

    override func getStrategy() -> PageStrategy? {
        return WanAndroidPageStrategy.init(pageStartNum: 0, pageSize: 20)
    }

    override func configTableView() {
        super.configTableView()

        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        self.tableView.register(ArticleListItemCell.self, forCellReuseIdentifier: ArticleListItemCell.description())
        self.tableView.register(ArticleBanner.self, forCellReuseIdentifier: ArticleBanner.description())
        self.tableView.backgroundColor = UIColor.project.background
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
            searchViewModel.search(index: wanPageInfo.pageStartNum)
        } else {
            searchViewModel.search(index: wanPageInfo.pageNum)
        }
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

extension SearchResultViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.dataSource[indexPath.section][indexPath.row] as? ArticleItem,
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListItemCell.description()) as? ArticleListItemCell {
            cell.setModel(item: model)
//            cell.addRecognizerToLikeBtn(onLikeBtnClick(_:), index: indexPath.row)
//            cell.addRecognizerToShareBtn(onShareBtnClick(_:), index: indexPath.row)
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

}
