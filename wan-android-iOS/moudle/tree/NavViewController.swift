//
//  NavViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/21.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout

class NavViewController: BaseViewController {
    private let treeViewModel = TreeViewModel.init()
    
    private var naviList: [NaviListModel] = []
    
    private let tagFlowLayout: MyFlexLayout = {
        let layout = MyFlexLayout.init()
        layout.padding = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        layout.myTrailing = CGFloat.init(4)
        layout.myLeading = CGFloat.init(4)
        layout.subviewSpace = 2
        layout.isFlex = true
        layout.myFlex.attrs.flex_wrap = MyFlexWrap_Wrap
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        treeViewModel.naviListLiveData.asObservable().subscribe { [weak self] (event) in
            guard let model = event.element else {
                return
            }
            
            if model.isEmpty {
                self?.showEmpty()
                return
            }
            
            self?.naviList.removeAll()
            self?.naviList.append(contentsOf: model)
            self?.refreshLayout()
            self?.showContent()
        }.disposed(by: disposeBag)
        
        treeViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }

            self?.showError(error: error)
        }.disposed(by: disposeBag)
    
        self.showLoading()
        self.treeViewModel.naviList()
    }
    
    override func initView() {
        super.initView()
        
        tagFlowLayout.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())
        self.parentView.addSubview(tagFlowLayout)
    }
    
    private func refreshLayout() {
        self.tagFlowLayout.removeAllSubviews()
        self.naviList.forEach { (naviListModel) in
            naviListModel.articles.forEach { (articleItem) in
                let label = self.createArtilceLabel(item: articleItem)
                label.mySize = CGSize.init(width: MyLayoutSize.wrap(), height:  MyLayoutSize.wrap())
                tagFlowLayout.addSubview(label)
            }
        }
    }
    
    private func createArtilceLabel(item: ArticleItem) -> UILabel {
        let label: TagView = {
            let label = TagView.init()
            label.font = UIFont.systemFont(ofSize: 16)
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.project.primary.cgColor
            label.backgroundColor = UIColor.project.primary
            label.layer.cornerRadius = 10
            label.color = UIColor.project.primary
            label.textColor = UIColor.white
            return label
        }()

        label.text = item.title

        return label
    }
}

extension NavViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.naviList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NaviItemCell.description()) as? NaviItemCell {
            let models = self.naviList[indexPath.row]
            cell.setModel(item: models.articles)
            return cell
        } else {
            let cell = NaviItemCell.init(style: .default, reuseIdentifier: NaviItemCell.description())
            let models = self.naviList[indexPath.row]
            cell.setModel(item: models.articles)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = naviList[indexPath.section].articles[indexPath.row]
        
        BrowserViewController.jump(vc: self, url: model.link)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.init(150)
    }
}
