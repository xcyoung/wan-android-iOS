//
//  NaviItemCell.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/21.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import MyLayout
class NaviItemCell: UITableViewCell {
    private var articleItems = [ArticleItem]()

    private let layout: MyFlowLayout = {
        let layout = MyFlowLayout.init()

        return layout
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        layout.frame = CGRect.init(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        layout.padding = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        layout.myTrailing = CGFloat.init(4)
        layout.myLeading = CGFloat.init(4)
        layout.subviewSpace = 2

        self.contentView.addSubview(self.layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        layout.removeAllSubviews()
//        articleItems.forEach { (articleItem) in
//            let label = createArtilceLabel(item: articleItem)
//            label.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.wrap())
//            self.layout.addSubview(label)
//        }
//        layout.layoutSubviews()
    }

    override var frame: CGRect {
        didSet {
            layout.frame = self.contentView.frame
        }
    }

    func setModel(item: [ArticleItem]) {
//        self.articleItems.removeAll()
//        self.articleItems.append(contentsOf: item)
//        self.layoutSubviews()
        layout.removeAllSubviews()
        item.forEach { (articleItem) in
            let label = createArtilceLabel(item: articleItem)
            label.mySize = CGSize.init(width: MyLayoutSize.wrap(), height: MyLayoutSize.wrap())
            self.layout.addSubview(label)
        }
        
    }

    private func createArtilceLabel(item: ArticleItem) -> UILabel {
        let label: TagView = {
            let label = TagView.init()
            label.font = UIFont.systemFont(ofSize: 16)
            label.color = UIColor.project.primary
            return label
        }()

        label.text = item.title

        return label
    }

    private func sizeWithText(text: String, font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect: CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
}
