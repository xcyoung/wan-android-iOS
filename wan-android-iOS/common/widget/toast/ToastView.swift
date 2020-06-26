//
//  ToastView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class ToastView: UIView {
    let textLabel: UILabel
    let iconView: UIImageView

    override init(frame: CGRect) {
        iconView = UIImageView.init(frame: CGRect.zero)
        iconView.backgroundColor = UIColor.white

        textLabel = UILabel.init(frame: CGRect.zero)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.numberOfLines = 0

        super.init(frame: frame)

        backgroundColor = Toast.defaultBackgroukColor
        layer.cornerRadius = 8
        
        addSubview(iconView)
        addSubview(textLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let superWidth = self.superview?.frame.width ?? UIScreen.main.bounds.width
        let superHeight = self.superview?.frame.height ?? UIScreen.main.bounds.height

        let constraintSize = CGSize.init(width: superWidth - 80, height: CGFloat.greatestFiniteMagnitude)
        let textLabelSize = self.textLabel.sizeThatFits(constraintSize)

        let y = superHeight - 100 - textLabelSize.height

        self.frame = CGRect.init(x: 0.5 * (superWidth - textLabelSize.width - 60), y: y, width: textLabelSize.width + 60, height: textLabelSize.height + 30)
        self.textLabel.frame = CGRect.init(x: 30 + 14, y: 15, width: textLabelSize.width, height: textLabelSize.height)
        self.iconView.frame = CGRect.init(x: 2 + 14, y: 0.5 * (self.frame.height - 20), width: 20, height: 20)
    }

}
