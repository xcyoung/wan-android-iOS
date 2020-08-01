//
//  ArticleBanner.swift
//  wan-android-iOS
//
//  Created by idt on 2020/7/31.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class ArticleBanner: UITableViewCell {
    private var articleBanners: [ArticleBannerItem] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        self.addSubview(bannerCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerCollectionView.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    private let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize.init(width: frame.width, height: frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let banner = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        banner.showsVerticalScrollIndicator = false
        banner.showsHorizontalScrollIndicator = false
        banner.allowsSelection = false
        banner.allowsMultipleSelection = false
        banner.register(ArticleBannerItemCell.self, forCellWithReuseIdentifier: ArticleBannerItemCell.description())
        return banner
    }()
    
    func setItems(banners: [ArticleBannerItem]) {
        articleBanners.removeAll()
        articleBanners.append(contentsOf: banners)
        bannerCollectionView.reloadData()
    }
}

extension ArticleBanner: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleBannerItemCell.description(), for: indexPath) as? ArticleBannerItemCell else {
            return UICollectionViewCell.init()
        }
        cell.setModel(item: articleBanners[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return frame.size
    }
}
