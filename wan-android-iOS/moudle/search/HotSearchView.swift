//
//  HotSearchView.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/19.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class HotSearchView: UIView {
    private var hotSearchModels = [HotSearchModel]()
    let itemHeight = 35
    
    var onItemClickListener: ((_ index: Int, _ model: HotSearchModel) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHotSearchModels(hotSearchModels: [HotSearchModel]) {
        self.hotSearchModels.removeAll()
        self.hotSearchModels.append(contentsOf: hotSearchModels)
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        layout()
    }

    private func createHotSearchItem(index: Int) -> UILabel {
        let x: CGFloat
        if index % 2 == 0 {
            x = 0
        } else {
            x = frame.width / 2
        }
        let y: CGFloat
        if index % 2 == 0 {
            y = CGFloat((index / 2) * itemHeight)
        } else {
            y = CGFloat(((index - 1) / 2) * itemHeight)
        }
        let label = PaddingLabel.init(frame: CGRect.init(x: x, y: y, width: frame.width / 2, height: CGFloat(itemHeight)))
        
        label.textColor = UIColor.project.text
        label.textInsets = UIEdgeInsets.init(top: 8, left: 12, bottom: 8, right: 4)
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        return label
    }

    private func layout() {
        let frameHeight = ceil(Double.init(hotSearchModels.count) / 2) * Double.init(itemHeight)
        frame = CGRect.init(x: frame.minX,
                            y: frame.minY,
                            width: frame.width,
                            height: CGFloat(frameHeight))
        
        for i in 0..<hotSearchModels.count {
            let model = hotSearchModels[i]
            let label = createHotSearchItem(index: i)
            label.text = "\(i + 1)、\(model.name)"
            label.tag = i
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(onItemClick(_:)))
            label.addGestureRecognizer(tap)
            self.addSubview(label)
        }
    }
    
    @objc private func onItemClick(_ sender: UIGestureRecognizer) {
        if let view = sender.view {
            self.onItemClickListener?(view.tag, self.hotSearchModels[view.tag])
        }
    }
}
