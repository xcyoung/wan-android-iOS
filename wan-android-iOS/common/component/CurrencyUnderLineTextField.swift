//
//  CurrencyUnderLineTextField.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class CurrencyUnderLineTextField: UITextField {

    var lineColor: UIColor = UIColor.gray
    var lineHeight: CGFloat = 0.5
    var contentEdgeInsets: UIEdgeInsets = .zero
    override func draw(_ rect: CGRect) {
        //线条的高度
        let lineHeight: CGFloat = self.lineHeight
        //线条的颜色
        let lineColor = self.lineColor

        guard let content = UIGraphicsGetCurrentContext() else { return }
        content.setFillColor(lineColor.cgColor)
        content.fill(CGRect.init(
            x: 0,
            y: self.frame.height - lineHeight,
            width: self.frame.width,
            height: lineHeight))
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect.init(
            x: bounds.minX + contentEdgeInsets.left,
            y: bounds.minY + contentEdgeInsets.top,
            width: bounds.width - contentEdgeInsets.left - contentEdgeInsets.right,
            height: bounds.height - contentEdgeInsets.top - contentEdgeInsets.bottom)

        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect.init(
            x: bounds.minX + contentEdgeInsets.left,
            y: bounds.minY + contentEdgeInsets.top,
            width: bounds.width - contentEdgeInsets.left - contentEdgeInsets.right,
            height: bounds.height - contentEdgeInsets.top - contentEdgeInsets.bottom)

        return rect
    }
}
