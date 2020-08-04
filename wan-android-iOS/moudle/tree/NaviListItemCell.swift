//
//  NaviListItemCell.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class NaviListItemCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        self.layer.cornerRadius = frame.height / 2
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 1)
        
        self.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
//        selectedBackgroundView = UIView.init(frame: frame)
//        selectedBackgroundView?.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
    }
    
    func setModel(item: ArticleItem) {
        label.text = item.title
    }
}
