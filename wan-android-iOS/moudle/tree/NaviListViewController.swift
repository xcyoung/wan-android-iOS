//
//  NaviListViewController.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class NaviListViewController: BaseViewController {
    private let treeViewModel = TreeViewModel.init()

    private var naviList: [NaviListModel] = []

    private let collectionView: UICollectionView = {
        // TODO: 左对齐需要改进
        let layout = LeftEqualFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(hex6: 0xf9f9f9, alpha: 1)
        collectionView.register(NaviListItemCell.self, forCellWithReuseIdentifier: NaviListItemCell.description())
        collectionView.register(NaviListHeaderView.self, forSupplementaryViewOfKind: NaviListHeaderView.description(), withReuseIdentifier: NaviListHeaderView.description())
        return collectionView
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
            self?.collectionView.reloadData()
            self?.showContent()
        }.disposed(by: disposeBag)
        
        treeViewModel.errorLiveData.asObservable().subscribe { [weak self] (event) in
            guard let error = event.element as? XError else {
                return
            }

            self?.showError(error: error)
        }.disposed(by: disposeBag)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.showLoading()
        self.treeViewModel.naviList()
    }

    override func initView() {
        super.initView()

        collectionView.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.fill())

        self.parentView.addSubview(collectionView)
    }

}

extension NaviListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return naviList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return naviList[section].articles.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: NaviListHeaderView.description(), withReuseIdentifier: NaviListHeaderView.description(), for: indexPath) as? NaviListHeaderView else {
            return UICollectionReusableView.init()
        }
        view.setModel(item: naviList[indexPath.section])
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NaviListItemCell.description(), for: indexPath) as? NaviListItemCell {
            let model = self.naviList[indexPath.section].articles[indexPath.row]
            cell.setModel(item: model)
            return cell
        }
        
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.naviList[indexPath.section].articles[indexPath.row]
        let titleSize = model.title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
        let size = CGSize.init(width: titleSize.width + 20, height: titleSize.height + 20)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = naviList[indexPath.section].articles[indexPath.row]
        
        BrowserViewController.jump(vc: self, url: model.link)
    }
}
