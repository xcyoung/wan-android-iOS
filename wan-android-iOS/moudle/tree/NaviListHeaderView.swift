//
//  NaviListHeaderView.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class NaviListHeaderView: UICollectionReusableView {
    private let label: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let labelRect = label.textRect(forBounds: self.frame, limitedToNumberOfLines: 1)
        let y = self.frame.height / 2 - labelRect.height / 2
        label.frame = CGRect.init(x: 10, y: y, width: labelRect.width, height: labelRect.height)
    }
    
    func setModel(item: NaviListModel) {
        label.text = item.name
    }
}
