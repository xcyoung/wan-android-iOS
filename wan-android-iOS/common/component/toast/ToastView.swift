//
//  ToastView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import Lottie
class ToastView: UIView {
    let textLabel: UILabel
    let iconView: AnimationView

    override init(frame: CGRect) {
        let animation = Animation.nameWithMode("alert_circle", subdirectory: "animation/alert_circle")

        iconView = AnimationView.init(frame: CGRect.zero)
        iconView.animation = animation
        iconView.contentMode = .scaleAspectFit
        iconView.backgroundBehavior = .pauseAndRestore

        textLabel = UILabel.init(frame: CGRect.zero)
        textLabel.textColor = UIColor.project.toastLabel
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

        self.frame = CGRect.init(x: 0.5 * (superWidth - textLabelSize.width - 70), y: y, width: textLabelSize.width + 70, height: textLabelSize.height + 30)
        self.textLabel.frame = CGRect.init(x: 40 + 14, y: 15, width: textLabelSize.width, height: textLabelSize.height)
        self.iconView.frame = CGRect.init(x: 2 + 14, y: 0.5 * (self.frame.height - 30), width: 30, height: 30)
    }

    func showAnimation() {
        iconView.play(fromProgress: 0,
            toProgress: 1,
            loopMode: LottieLoopMode.repeat(2),
            completion: { (finished) in
            })
    }
}
