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
        self.addSubview(banner)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banner.frame = frame
    }
    
    private let banner: XBanner = {
        let banner = XBanner.init()
        banner.scrollDirection = .horizontal
        banner.isAuto = true
        return banner
    }()
    
    func setItems(banners: [ArticleBannerItem]) {
        articleBanners.removeAll()
        articleBanners.append(contentsOf: banners)
        banner.setItem(banners.map({ $0.imagePath }))
    }
}
