//
//  TreeSubListItemCell.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/20.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout

class TreeSubListItemCell: UITableViewCell {
    let authorLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.project.text
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectedBackgroundView = UIView.init(frame: frame)
        selectedBackgroundView?.backgroundColor = UIColor.project.background
        self.contentView.backgroundColor = UIColor.project.background
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let viewGroup = MyLinearLayout.init()
        viewGroup.myBottom = CGFloat.init(4)
        viewGroup.mySize = CGSize.init(width: MyLayoutSize.fill(), height: 100)
        viewGroup.padding = UIEdgeInsets.init(top: 8, left: 16, bottom: 4, right: 16)
        viewGroup.orientation = MyOrientation_Vert
        viewGroup.backgroundColor = UIColor.project.item

        authorLabel.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.wrap())

//        titleLabel.myTop = CGFloat.init(4)
        titleLabel.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())

//        timeLabel.myTop = CGFloat.init(4)
        timeLabel.mySize = CGSize.init(width: MyLayoutSize.fill(), height: MyLayoutSize.wrap())
        
        viewGroup.addSubview(authorLabel)
        viewGroup.addSubview(titleLabel)
        viewGroup.addSubview(timeLabel)
        viewGroup.equalizeSubviewsSpace(true)
        self.contentView.addSubview(viewGroup)
    }

    func setModel(item: ArticleItem) {
        authorLabel.text = item.author.isEmpty ? "\(item.shareUser)" : "\(item.author)(Author)"

        timeLabel.text = item.niceDate

        titleLabel.text = item.title
    }
}
