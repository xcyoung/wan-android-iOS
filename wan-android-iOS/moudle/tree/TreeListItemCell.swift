//
//  TreeListItemCell.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/3.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class TreeListItemCell: UITableViewCell {
    private let label: UILabel = {
        let label = UILabel.init()
//        label.textColor = UIColor.gray
//        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.init(hex6: 0xf9f9f9, alpha: 1)
        
        selectedBackgroundView = UIView.init(frame: frame)
        selectedBackgroundView?.backgroundColor = UIColor.init(hex6: 0xf9f9f9, alpha: 1)
        
        label.frame = CGRect.init(x: 10, y: 0, width: frame.width - 10, height: frame.height - 0.5)
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(item: TreeListModel) {
        label.text = item.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {        
        if selected {
            label.textColor = UIColor.project.primary
            label.font = UIFont.systemFont(ofSize: 14)
        } else {
            label.textColor = UIColor.gray
            label.font = UIFont.systemFont(ofSize: 12)
        }
    }
}
