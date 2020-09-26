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
        case searchHistory = "wan_android_searchHistory"
    }
    
    func getUserKey(key: String) -> String {
        if let userInfo = getUserInfo() {
            return "\(key)_[\(userInfo.id)]"
        } else {
            return key
        }
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
    
    func saveSearchHistory(keyword: String) {
        if var history = UserDefaults.standard.array(forKey: getUserKey(key: UserDefaultKey.searchHistory.rawValue)) as? [String] {
            if !history.contains(keyword) {
                if history.count >= 10 {
                    history.removeLast()
                }
                history.insert(keyword, at: 0)
                UserDefaults.standard.set(history, forKey: getUserKey(key: UserDefaultKey.searchHistory.rawValue))
            }
        } else {
            UserDefaults.standard.set([keyword], forKey: getUserKey(key: UserDefaultKey.searchHistory.rawValue))
        }
    }
    
    func getSearchHistory() -> [String] {
        if let history = UserDefaults.standard.array(forKey: getUserKey(key: UserDefaultKey.searchHistory.rawValue)) as? [String] {
            return history
        } else {
            return []
        }
    }
    
    func clearSearchHistory() {
        UserDefaults.standard.removeObject(forKey: getUserKey(key: UserDefaultKey.searchHistory.rawValue))
    }
}
