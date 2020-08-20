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
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let selectedLabel: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = UIColor.project.primary
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(selectedLabel)
        
        setSelected(false, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selectedLabelHeight = frame.height / 3
        selectedLabel.frame = CGRect.init(x: 0, y: (frame.height - selectedLabelHeight) / 2, width: 5, height: selectedLabelHeight)
        
        label.frame = CGRect.init(x: 10, y: 0, width: frame.width - 10, height: frame.height - 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(item: TreeListModel) {
        label.text = item.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {        
        if selected {
            contentView.backgroundColor = UIColor.project.item
            label.textColor = UIColor.project.primary
            label.font = UIFont.systemFont(ofSize: 14)
            selectedLabel.isHidden = false
        } else {
            contentView.backgroundColor = UIColor.project.background
            label.textColor = UIColor.project.text
            label.font = UIFont.systemFont(ofSize: 12)
            selectedLabel.isHidden = true
        }
    }
}
