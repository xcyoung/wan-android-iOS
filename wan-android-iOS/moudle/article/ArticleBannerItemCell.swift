//
//  ArticleBannerCell.swift
//  wan-android-iOS
//
//  Created by idt on 2020/7/31.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class ArticleBannerItemCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView.init(frame: CGRect.zero)
        image.backgroundColor = UIColor.systemGray
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(item: ArticleBannerItem) {
        imageView.load(item.imagePath)
    }
}
