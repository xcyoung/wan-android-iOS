//
//  HttpClient.swift
//  wan-android-iOS
//
//  Created by idt on 2020/6/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
//  需要鉴权信息的请求
enum AuthStatePath: String, CaseIterable {
    case collectInside = "lg/collect/"
    case unCollectInside = "lg/uncollect_originId/"
}

class HttpClient: NSObject {
    private let baseUrl: String
    private var headers: HTTPHeaders

    public init(baseUrl url: String, headers: HTTPHeaders? = nil) {
        if headers != nil,
            let h = headers {
            self.headers = [:]
            for (key, value) in h {
                self.headers[key] = value
            }
        } else {
            self.headers = [:]
        }
        self.baseUrl = url
        super.init()
    }

    func requestByRx<T: Codable>(url: String,
        method: HTTPMethod,
        encoding: ParameterEncoding = URLEncoding.default,
        pathParams: Dictionary<String, String> = [:],
        params: Dictionary<String, Any> = [:]) -> Observable<T> {
        if let _ = AuthStatePath.allCases.first(where: {
            url.contains($0.rawValue)
        }) {
            if LocalStroage.shared.getCookie() == nil ||
                LocalStroage.shared.getUserInfo() == nil {
                return Observable<T>.error(XError.init(code: ErrorCode.localLoginInvalid.rawValue, message: "请先登录"))
            }
        }
        
        var requestUrl = baseUrl + url

        for (key, value) in pathParams {
            requestUrl = requestUrl.replacingOccurrences(of: "{\(key)}", with: "\(value)")
        }

        getCookie()

        #if DEBUG
            return requestString(method, requestUrl, parameters: params, encoding: encoding, headers: self.headers)
                .debug()
                .map { [weak self] (response, jsonString) -> T in
                    self?.saveCookie(response: response)
                    self?.saveUserInfo(response: response, userInfoJson: jsonString)
                    if let model: T = JsonUtils.jsonParse(jsonStr: jsonString) {
                        return model
                    } else {
                        throw XError.init(code: -1, message: "json解析异常")
                    }
            }
        #else
            return requestString(method, requestUrl, parameters: params, encoding: encoding, headers: self.headers)
                .map { [weak self] (response, jsonString) -> T in
                    self?.saveCookie(response: response)
                    self?.saveUserInfo(response: response, userInfoJson: jsonString)
                    if let model: T = JsonUtils.jsonParse(jsonStr: jsonString) {
                        return model
                    } else {
                        throw XError.init(code: -1, message: "json解析异常")
                    }
            }
        #endif
    }

    private func saveCookie(response: HTTPURLResponse) {
        guard let headerFields = response.allHeaderFields as? [String: String],
            let url = response.url,
            url.absoluteString.contains("user/login")
            else {
                return
        }
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
        var cookieArray = [[HTTPCookiePropertyKey: Any]]()
        for cookie in cookies {
            cookieArray.append(cookie.properties!)
        }
        LocalStroage.shared.saveCookie(cookieArray: cookieArray)
    }

    private func getCookie() {
        if let cookieArray = LocalStroage.shared.getCookie() {
            for cookieData in cookieArray {
                let dict = cookieData
                if let cookie = HTTPCookie.init(properties: dict) {
                    Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookie(cookie)
                }
            }
        }
    }

    private func saveUserInfo(response: HTTPURLResponse, userInfoJson: String) {
        guard let url = response.url,
            url.absoluteString.contains("user/login") else {
            return
        }
        
        LocalStroage.shared.saveUserInfo(userInfoJson: userInfoJson)
    }
}
