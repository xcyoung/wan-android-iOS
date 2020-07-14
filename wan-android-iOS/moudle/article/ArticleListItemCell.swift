//
//  ArticleListItemCell.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/7.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class ArticleListItemCell: UITableViewCell {
    let authorLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel.init()

        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    let newLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "新"
        return label
    }()

    let topLabel: UILabel = {
        let label = UILabel.init()

        return label
    }()

    let chapterLabel: UILabel = {
        let label = UILabel.init()

        return label
    }()

    let tagFlowLayout: MyFlowLayout? = {
        let flowLayout = MyFlowLayout.init(orientation: MyOrientation_Vert, arrangedCount: 0)

        return flowLayout
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        let topView = MyFlexLayout.init()
        topView.myHeight = CGFloat.init(MyLayoutSize.wrap())
        topView.myWidth = CGFloat.init(MyLayoutSize.fill())
        topView.padding = UIEdgeInsets.init(top: 16, left: 8, bottom: 4, right: 8)
        topView.isFlex = true
        topView.myFlex.attrs.justify_content = MyFlexGravity_Space_Between
        newLabel.mySize = CGSize.init(width: 20, height: 20)

        authorLabel.alignment = MyGravity_Vert_Center
        authorLabel.myLeft = CGFloat.init(4)
        authorLabel.myWidth = CGFloat.init(MyLayoutSize.wrap())
        authorLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())
        authorLabel.myFlex.attrs.flex_grow = 2
        
        timeLabel.alignment = MyGravity_Vert_Center
        timeLabel.myWidth = CGFloat.init(MyLayoutSize.wrap())
        timeLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())

        topView.addSubview(newLabel)
        topView.addSubview(authorLabel)
        topView.addSubview(timeLabel)

        self.addSubview(topView)
    }

    func setModel(item: ArticleItem) {
        newLabel.visibility = item.fresh ? MyVisibility_Visible: MyVisibility_Gone

        authorLabel.text = item.author.isEmpty ? item.shareUser : item.author

        timeLabel.text = item.niceDate
    }
}
