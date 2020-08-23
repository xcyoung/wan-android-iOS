//
//  AccountViewModel.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation

enum AccountView: Int {
    case select = 0
    case signIn = 1
    case signUp = 2
}

class AccountViewModel: BaseViewModel {
    let viewSwtichLiveData = RxLiveData<(from: AccountView, to: AccountView)>.init(defalutValue: (from: .select, to: .select))
    let dismissLiveData = RxLiveData<Bool>.init(defalutValue: false)
    private var accountView: AccountView = .select
    func onViewSwtich(accountView: AccountView) {
        viewSwtichLiveData.value = (from: self.accountView, to: accountView)
        self.accountView = accountView
    }

    func goBack() {
        switch accountView {
        case .select:
            dismissLiveData.value = true
            break
        case .signIn, .signUp:
            onViewSwtich(accountView: .select)
            break
//        default:
//            onViewSwtich(accountView: .select)
//            break
        }
    }
}
