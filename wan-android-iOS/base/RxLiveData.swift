//
//  RxLiveData.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//
import Foundation
import RxSwift

public class RxLiveData<Element> {
    private var liveDataValue: Element
    private var variable: PublishSubject<Element>
    public var value: Element {
        get {
            return liveDataValue
        }
        set {
            liveDataValue = newValue
            variable.onNext(newValue)
        }
    }
    
    public init(defalutValue: Element) {
        liveDataValue = defalutValue
        variable = PublishSubject<Element>()
    }

    public func asObservable() -> Observable<Element> {
        return variable.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentMainScheduler.instance)
    }
}
