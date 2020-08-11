//
//  DefaultErrorView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/27.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
protocol ErrorViewProtocol {
    func setError(error: XError?)
}

class DefaultErrorView: UIView, AnimationProtocol, ErrorViewProtocol {
    let label = UILabel.init()

    func startLoading() {
        //
    }

    func stopLoading() {
        //
    }

    override init(frame: CGRect) {
        label.text = "Error"

        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubview(label)
        layout()
        self.backgroundColor = UIColor.white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let loadingSize = CGFloat.init(200)
        label.frame = CGRect.init(x: (frame.width - loadingSize) / 2, y: (frame.height - loadingSize) / 2, width: loadingSize, height: loadingSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func setError(error: XError?) {
        label.text = error?.localizedDescription ?? ""
    }
}
