//
//  DefaultLoadingView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/27.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
import Lottie
class DefaultLoadingView: UIView, AnimationProtocol {
    func startLoading() {
        guard !loadingAnimationView.isAnimationPlaying else {
            return
        }
        loadingAnimationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }

    func stopLoading() {
        if loadingAnimationView.isAnimationPlaying {
            loadingAnimationView.stop()
        }
    }

    let loadingAnimationView: AnimationView

    override init(frame: CGRect) {
        let animation = Animation.nameWithMode("loading")

        loadingAnimationView = AnimationView.init()
        loadingAnimationView.animation = animation
        loadingAnimationView.contentMode = .scaleAspectFill
        loadingAnimationView.backgroundBehavior = .pauseAndRestore

        super.init(frame: frame)
        addSubview(loadingAnimationView)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let loadingSize = CGFloat.init(200)
        loadingAnimationView.frame = CGRect.init(x: (frame.width - loadingSize) / 2, y: (frame.height - loadingSize) / 2, width: loadingSize, height: loadingSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}
