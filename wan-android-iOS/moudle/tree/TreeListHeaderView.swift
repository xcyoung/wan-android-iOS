//
//  TreeListHeaderView.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class TreeListHeaderView: UITableViewHeaderFooterView {
    private let label: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.backgroundView = UIView.init(frame: frame)
        self.backgroundView?.backgroundColor = UIColor.project.item
        self.contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelRect = label.textRect(forBounds: self.contentView.frame, limitedToNumberOfLines: 1)
        let y = self.contentView.frame.height / 2 - labelRect.height / 2
        label.frame = CGRect.init(x: 10, y: y, width: labelRect.width, height: labelRect.height)
    }
    
    func setModel(item: TreeListModel) {
        label.text = item.name
    }
}
