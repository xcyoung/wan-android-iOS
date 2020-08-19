//
//  TagView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class TagView: PaddingLabel {
    var color: UIColor = UIColor.project.lightSecondary {
        didSet {
            self.layer.borderColor = color.cgColor
            self.textColor = color
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 10)
        self.layer.borderWidth = 1
        self.layer.borderColor = self.color.cgColor
        self.layer.cornerRadius = 2

        self.textColor = self.color
        self.textInsets = .init(top: 2, left: 2, bottom: 2, right: 2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
