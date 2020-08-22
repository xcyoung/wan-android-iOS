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
    public var onStatusClickCallback: (() -> Void)?
    let statusImageView: UIImageView = {
        let img = UIImageView.init()
        img.image = R.image.wan_img_empty_status()
        return img
    }()
    let label: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.project.text
        label.textAlignment = .center
        return label
    }()
    
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
        addSubview(statusImageView)
        layout()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onStatusTap(_:)))
        statusImageView.isUserInteractionEnabled = true
        statusImageView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
       let loadingSize = CGFloat.init(200)
        statusImageView.frame = CGRect.init(x: (frame.width - 250) / 2, y: (frame.height - loadingSize) / 2, width: 250, height: loadingSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @objc private func onStatusTap(_ recognizer: UIGestureRecognizer) {
        onStatusClickCallback?()
    }
}
