//
//  SearchGuideViewController.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class SearchGuideViewController: BaseViewController {
    private let searchViewModel: SearchViewModel
    private let hotSearchTitle: PaddingLabel = {
        let label = PaddingLabel.init()
        label.text = "热搜"
        label.textColor = UIColor.project.text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textInsets = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 0)
        return label
    }()
    
    private let hotSearchView: HotSearchView = {
        let view = HotSearchView.init()
        
        return view
    }()
    
    private let searchHistoryTitle: PaddingLabel = {
        let label = PaddingLabel.init()
        label.text = "搜索历史"
        label.textColor = UIColor.project.text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textInsets = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 0)
        return label
    }()
    
    private let historyFlowLayout: FlowLayout = {
        let flowLayout = FlowLayout.init()
        flowLayout.spacing = 12
        return flowLayout
    }()
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.project.item
        searchViewModel.hotkeyLiveData.asObservable().subscribe { [weak self] (event) in
            guard let hotkey = event.element else {
                return
            }
            
            self?.hotSearchView.setHotSearchModels(hotSearchModels: hotkey)
            self?.updateLayout()
            self?.searchViewModel.getHistory()
        }.disposed(by: disposeBag)
        
        searchViewModel.searchHistoryLiveData.asObservable().subscribe { [weak self] (event) in
            guard let history = event.element,
                  let this = self else {
                return
            }
            
            this.updateHistoryLayout(history: history)
        }.disposed(by: disposeBag)
        
        hotSearchView.onItemClickListener = { [weak self] (index, model) in
            self?.searchViewModel.onGuideSearch(keyword: model.name)
        }
        
        searchViewModel.getHotKey()
    }
    
    override func initView() {
        super.initView()
        
        hotSearchTitle.frame = CGRect.init(x: 0, y: 0, width: view.matchWidth, height: 35)
        hotSearchView.frame = CGRect.init(x: 0, y: 35, width: view.matchWidth, height: 500)
        self.view.addSubview(hotSearchTitle)
        self.view.addSubview(hotSearchView)
        self.view.addSubview(searchHistoryTitle)
        self.view.addSubview(historyFlowLayout)
    }
    
    private func updateLayout() {
        searchHistoryTitle.frame = CGRect.init(x: 0, y: hotSearchView.frame.maxY + 10, width: view.matchWidth, height: 35)
        historyFlowLayout.frame = CGRect.init(x: 0, y: searchHistoryTitle.frame.maxY, width: view.matchWidth, height: 500)
    }
    
    private func updateHistoryLayout(history: [String]) {
        historyFlowLayout.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        history.forEach { (keyword) in
            let label = createHistoryItem(text: keyword)
            let size = keyword.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
            label.frame = CGRect.init(x: 0, y: 0, width: size.width + 32, height: size.height + 16)
            historyFlowLayout.addSubview(label)
        }
    }
    
    private func createHistoryItem(text: String) -> UILabel {
        let label = PaddingLabel.init()
        label.layer.backgroundColor = UIColor.project.background.cgColor
        label.textColor = UIColor.project.text
        label.layer.cornerRadius = 5
        label.text = text
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onHistoryItemClick(_:)))
        label.addGestureRecognizer(tap)
        return label
    }
    
    @objc private func onHistoryItemClick(_ sender: UIGestureRecognizer) {
        if let label = sender.view as? UILabel,
           let keyword = label.text {
            searchViewModel.onGuideSearch(keyword: keyword)
        }
    }
    
    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}
