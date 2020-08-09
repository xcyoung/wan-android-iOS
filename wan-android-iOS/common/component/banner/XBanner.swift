//
//  XBanner.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/2.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import UIKit
class XBanner: UIView {
    override init(frame: CGRect) {
        self.collectionView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout)
        self.pageControl = PageControl.init(frame: CGRect(x: 0.0, y: frame.height - 40, width: frame.width, height: 40))
        super.init(frame: frame)
        registerNotification()
        setupSubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        flowLayout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        pageControl.frame = CGRect(x: 0.0, y: frame.height - 20, width: frame.width, height: 20)
    }

    public var timeInterval: TimeInterval = 2.0

    public var isAuto: Bool = false

    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet {
            flowLayout.scrollDirection = self.scrollDirection
        }
    }

    private var items: [String] = []
    private var curIndex: Int = 0
    private var timer: Timer? = nil
    private var totalCount: Int = 0

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private let collectionView: UICollectionView

    private let pageControl: PageControl
    
    private func setupSubView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
        collectionView.register(XBannerItemCell.self, forCellWithReuseIdentifier: XBannerItemCell.description())
        collectionView.backgroundColor = UIColor.white

        let size = CGSize(width: 15.0, height: 3.0)
        let path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 10)
        pageControl.setPath(path, for: .normal)
        pageControl.setPath(path, for: .selected)
        pageControl.setFillColor(UIColor(white: 0.0, alpha: 0.3), for: .normal)
        pageControl.setFillColor(UIColor.systemGreen, for: .selected)
        pageControl.itemSpacing = 14.0
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupTimer() {
        destoryTimer()
        guard isAuto else {
            return
        }

        self.timer = Timer.init(timeInterval: self.timeInterval, target: self, selector: #selector(updateAction(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }

    private func destoryTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateAction(_ timer: Timer) {
        if scrollDirection == .horizontal {
            let point = CGPoint(x: CGFloat(curIndex + 1) * bounds.width, y: 0)
            collectionView.setContentOffset(point, animated: true)
        } else {
            let point = CGPoint(x: 0, y: CGFloat(curIndex + 1) * bounds.height)
            collectionView.setContentOffset(point, animated: true)
        }
    }
    
    private func timerPause() {
        timer?.fireDate = Date.distantFuture
    }
    
    private func timerRestart() {
        timer?.fireDate = Date() + timeInterval
    }

    private func registerNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(registerNoti(_:)), name: Notification.Name("UIApplicationDidBecomeActiveNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(registerNoti(_:)), name: Notification.Name("UIApplicationDidEnterBackgroundNotification"), object: nil)
    }
    
    @objc private func registerNoti(_ notification: Notification) {
        if notification.name == Notification.Name("UIApplicationDidBecomeActiveNotification") {
            timerRestart()
        } else {
            timerPause()
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            destoryTimer()
        }
    }
    
    deinit {
        destoryTimer()
    }
}

extension XBanner {
    func setItem(_ items: [String]) {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        if isAuto && items.count > 1 {
            setupTimer()
        } else {
            destoryTimer()
        }
        totalCount = items.count * 1024
        pageControl.numberOfPages = items.count
        collectionView.reloadData()
        let indexPath = IndexPath.init(item: totalCount / 2, section: 0)
        if scrollDirection == .vertical {
            collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        } else {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }

    }
}

extension XBanner: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XBannerItemCell.description(), for: indexPath) as? XBannerItemCell else {
            return UICollectionViewCell.init()
        }
        cell.setModel(item: items[indexPath.item % items.count])

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        if index != self.curIndex {
            let realIndex = getRealIndex(index)
            pageControl.currentPage = realIndex
        }
        curIndex = index
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timerPause()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        resetPosition()
        timerRestart()
    }
    
    private func getRealIndex(_ orginIndex: Int) -> Int {
        let itemCount = self.items.count
        return orginIndex % itemCount
    }

    private func getCurrentIndex() -> Int {
        if flowLayout.itemSize.width == 0 || flowLayout.itemSize.height == 0 {
            return 0
        }

        let index: Int
        if scrollDirection == .vertical {
            index = Int((collectionView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height)
        } else {
            index = Int((collectionView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width)
        }
        return max(0, index)
    }

    private func resetPosition() {
        let indexPath = IndexPath.init(item: curIndex, section: 0)
        if scrollDirection == .vertical {
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        } else {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
}
