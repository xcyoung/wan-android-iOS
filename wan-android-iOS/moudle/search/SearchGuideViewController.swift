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
        }.disposed(by: disposeBag)
        
        hotSearchView.onItemClickListener = { [weak self] (index, model) in
            self?.searchViewModel.onGuideSearch(keyword: model.name)
        }
        
        searchViewModel.getHotKey()
    }
    
    override func initView() {
        super.initView()
        
        hotSearchTitle.frame = CGRect.init(x: 0, y: 0, width: view.matchWidth, height: 35)
        hotSearchView.frame = CGRect.init(x: 0, y: hotSearchTitle.safeAreaBottom, width: view.matchWidth, height: 500)
        self.view.addSubview(hotSearchTitle)
        self.view.addSubview(hotSearchView)
    }
    
    override func getNavigationBarHidden() -> (hidden: Bool, animated: Bool) {
        return (hidden: true, animated: true)
    }
}
