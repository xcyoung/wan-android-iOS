//
//  FlowLayout.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/9/26.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
/*
    简单的流式布局，适合子view较少的场景
    目前保证子view不超过父view的宽度布局，超过宽度则换行
    MARK: - 因每次layoutSubviews时刷新，每次刷新会遍历计算宽度，故子view较多的情况不建议使用
 */
public class FlowLayout: UIView {
    public var spacing: CGFloat = 0
    public var reverse: Bool = false
    public var ignoreHidden: Bool = true
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        guard !subviews.isEmpty else {
            return
        }
        
        let margin = self.spacing
        
        var rowFirstViews = [UIView]()
        
        let beginIndex: Int
        if ignoreHidden {
            if let index = subviews.firstIndex(where: {$0.isHidden == false}) {
                beginIndex = index
            } else {
                beginIndex = -1
            }
        } else {
            beginIndex = 0
        }
        
        if beginIndex == -1 {
            return
        }
        
        let view0 = subviews[beginIndex]
        let view0Size = view0.frame.size
        let view0X: CGFloat
        if reverse {
            view0X = self.frame.width - margin - view0Size.width
        } else {
            view0X = margin
        }
        view0.frame = CGRect.init(x: view0X, y: margin, width: view0Size.width, height: view0Size.height)
        rowFirstViews.append(view0)
        
        var row = 0
        for i in (beginIndex + 1)..<subviews.count {
            let subView = subviews[i]
            if ignoreHidden && subView.isHidden == true {
                continue
            }
            
            var sumWidth = CGFloat.init(0)
            if let startIndex = subviews.firstIndex(of: rowFirstViews[row]) {
                for j in startIndex...i {
                    let view = subviews[j]
                    if ignoreHidden && view.isHidden == true {
                        continue
                    }
                    sumWidth += (view.frame.width + margin)
                }
            }
            sumWidth += margin
            
            let lastView = rowFirstViews[row]
            if sumWidth >= self.frame.width {
                let x: CGFloat
                let y = lastView.frame.minY + margin + lastView.frame.height
                let subViewSize = subView.frame.size
                if reverse {
                    x = self.frame.width - margin - subViewSize.width
                } else {
                    x = margin
                }
                subView.frame = CGRect.init(x: x, y: y, width: subViewSize.width, height: subViewSize.height)
                rowFirstViews.append(subView)
                row += 1
            } else {
                let x: CGFloat
                if reverse {
                    x = self.frame.width - sumWidth + margin
                } else {
                    x = sumWidth - margin - subView.frame.width
                }
                let y = lastView.frame.minY
                let subViewSize = subView.frame.size
                subView.frame = CGRect.init(x: x, y: y, width: subViewSize.width, height: subViewSize.height)
            }
        }
    }
}
