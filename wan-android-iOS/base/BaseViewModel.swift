//
//  BaseViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/6/25.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import RxSwift
class BaseViewModel: NSObject {
    public let errorLiveData = RxLiveData<XError?>.init(defalutValue: nil)
    public let disposeBag = DisposeBag.init()
}
