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
        label.textColor = UIColor.systemBlue
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "置顶"
        return label
    }()

    let chapterLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    let tagFlowLayout: MyFlowLayout? = {
        let flowLayout = MyFlowLayout.init(orientation: MyOrientation_Vert, arrangedCount: 0)

        return flowLayout
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView.init(frame: frame)
        selectedBackgroundView?.backgroundColor = UIColor.init(hex6: 0xf9f9f9, alpha: 1)
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTag(tag: Tag) {
        let tagLabel = UILabel.init()
        tagLabel.text = tag.name
        tagLabel.textColor = UIColor.systemYellow
        tagLabel.font = UIFont.systemFont(ofSize: 12)
        tagLabel.layer.borderWidth = 1
        tagLabel.layer.borderColor = UIColor.systemYellow.cgColor
        tagLabel.layer.cornerRadius = 2
        tagLabel.layoutMargins = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        tagLabel.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.wrap())
        
        tagFlowLayout?.addSubview(tagLabel)
    }
    
    func layout() {
        let view = MyFlexLayout.init()
        view.myHeight = CGFloat.init(MyLayoutSize.fill())
        view.myWidth = CGFloat.init(MyLayoutSize.fill())
        view.padding = UIEdgeInsets.init(top: 16, left: 16, bottom: 4, right: 16)
        view.isFlex = true
//        view.myFlex.attrs.justify_content = MyFlexGravity_Space_Between
        view.myFlex.attrs.flex_wrap = MyFlexWrap_Wrap
        
        newLabel.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 4)
        newLabel.mySize = CGSize.init(width: 20, height: MyLayoutSize.wrap())

        authorLabel.alignment = MyGravity_Vert_Center
        authorLabel.myWidth = CGFloat.init(MyLayoutSize.wrap())
        authorLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())
//        authorLabel.myFlex.attrs.flex_grow = 2

        if let tagFlowLayout = tagFlowLayout {
            tagFlowLayout.myWidth = CGFloat.init(MyLayoutSize.wrap())
            tagFlowLayout.myHeight = CGFloat.init(MyLayoutSize.wrap())
            tagFlowLayout.padding = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0)
            tagFlowLayout.myFlex.attrs.flex_grow = 2
            tagFlowLayout.subviewSpace = 2
        }
        
        timeLabel.alignment = MyGravity_Vert_Center
        timeLabel.myWidth = CGFloat.init(MyLayoutSize.wrap())
        timeLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())

        titleLabel.myWidth = CGFloat.init(MyLayoutSize.fill())
        titleLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())
        
        topLabel.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 4)
        topLabel.mySize = CGSize.init(width: 35, height: MyLayoutSize.wrap())
        
        chapterLabel.myWidth = CGFloat.init(MyLayoutSize.wrap())
        chapterLabel.myHeight = CGFloat.init(MyLayoutSize.wrap())
        chapterLabel.myFlex.attrs.flex_grow = 2
        chapterLabel.myFlex.attrs.align_self = MyFlexGravity_Flex_Start
        
        view.addSubview(newLabel)
        view.addSubview(authorLabel)
        if let tagFlowLayout = tagFlowLayout {
            view.addSubview(tagFlowLayout)
        }
        view.addSubview(timeLabel)
        view.addSubview(titleLabel)
        view.addSubview(topLabel)
        view.addSubview(chapterLabel)
        
        self.addSubview(view)
    }

    func setModel(item: ArticleItem) {
        newLabel.visibility = item.fresh ? MyVisibility_Visible: MyVisibility_Gone

        authorLabel.text = item.author.isEmpty ? "\(item.shareUser)" : "\(item.author)(Author)"

        timeLabel.text = item.niceDate

        titleLabel.text = item.title

        if item.type == 1 {
            topLabel.visibility = MyVisibility_Visible
            topLabel.text = "置顶"
        } else {
            topLabel.visibility = MyVisibility_Gone
        }
        
        chapterLabel.text = "\(item.superChapterName)/\(item.chapterName)"
        
        tagFlowLayout?.removeAllSubviews()
        if item.tags.count >= 2 {
            createTag(tag: item.tags[0])
            createTag(tag: item.tags[1])
        } else {
            item.tags.forEach { (tag) in
                createTag(tag: tag)
            }
        }
    }
}
