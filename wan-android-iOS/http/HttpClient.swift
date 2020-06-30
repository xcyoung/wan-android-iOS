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
        var requestUrl = baseUrl + url
        for (key, value) in pathParams {
            requestUrl = requestUrl.replacingOccurrences(of: "{\(key)}", with: "\(value)")
        }

        #if DEBUG
            return requestString(method, requestUrl, parameters: pathParams, encoding: encoding, headers: self.headers)
                .debug()
                .map { (response, jsonString) -> T in
                    if let model: T = JsonUtils.jsonParse(jsonStr: jsonString) {
                        return model
                    } else {
                        throw NSError.init()
                    }
            }
        #else
            return requestString(method, requestUrl, parameters: pathParams, encoding: encoding, headers: self.headers)
                .map { (response, jsonString) -> T in
                    if let model: T = JsonUtils.jsonParse(jsonStr: jsonString) {
                        return model
                    } else {
                        throw NSError.init()
                    }
            }
        #endif
    }
}
