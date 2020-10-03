//
//  LeftEqualFlowLayout.swift
//  wan-android-iOS
//
//  Created by idt on 2020/8/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit

class LeftEqualFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrs = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for i in 0..<attrs.count {
            if i > 0 {
                let preFrame = attrs[i - 1].frame
                let attr = attrs[i]
                var frame = attr.frame
                if preFrame.origin.y == frame.origin.y {
                    frame.origin.x = preFrame.maxX + self.minimumInteritemSpacing
                    attr.frame = frame
                } else if preFrame.origin.y < frame.origin.y {
                    frame.origin.x = 0 + self.minimumInteritemSpacing
                    attr.frame = frame
                }
            } else {
                let attr = attrs[i]
                var frame = attr.frame
                frame.origin.x = 0 + self.minimumInteritemSpacing
                attr.frame = frame
            }
        }
        return attrs
    }
}
