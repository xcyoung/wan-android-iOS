//
//  DefaultEmptyView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/27.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class DefaultEmptyView: UIView, AnimationProtocol {
    let label = UILabel.init()
    
    func startLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
    
    override init(frame: CGRect) {
        label.text = "Empty"
        
        super.init(frame: frame)
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
}
