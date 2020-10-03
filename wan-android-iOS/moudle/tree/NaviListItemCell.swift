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
    private let label: PaddingLabel = {
        let label = PaddingLabel.init()
        label.layer.backgroundColor = UIColor.project.item.cgColor
        label.textColor = UIColor.project.text
        label.layer.cornerRadius = 8
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textInsets = UIEdgeInsets.init(top: 8, left: 4, bottom: 8, right: 4)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        self.layer.cornerRadius = frame.height / 2
        self.backgroundColor = UIColor.project.primary
        
        self.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    func setModel(item: ArticleItem) {
        label.text = item.title
    }
}
