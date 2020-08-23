//
//  LocalStroage.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/8/23.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class LocalStroage: NSObject {
    public static let shared: LocalStroage = LocalStroage.init()
    
    enum UserDefaultKey: String {
        case cookie = "wan_android_cookie"
        case userInfo = "wan_android_userInfo"
    }
    
    func saveCookie(cookieArray: [[HTTPCookiePropertyKey: Any]]) {
        UserDefaults.standard.set(cookieArray, forKey: UserDefaultKey.cookie.rawValue)
    }
    
    func getCookie() -> [[HTTPCookiePropertyKey: Any]]? {
        return UserDefaults.standard.array(forKey: UserDefaultKey.cookie.rawValue) as? [[HTTPCookiePropertyKey : Any]]
    }
    
    func saveUserInfo(userInfoJson: String) {
        UserDefaults.standard.set(userInfoJson, forKey: UserDefaultKey.userInfo.rawValue)
    }
    
    func getUserInfo() -> UserInfo? {
        if let json = UserDefaults.standard.string(forKey: UserDefaultKey.userInfo.rawValue),
            let userInfo: UserInfo = JsonUtils.jsonParse(jsonStr: json) {
            return userInfo
        } else {
            return nil
        }
    }
}
