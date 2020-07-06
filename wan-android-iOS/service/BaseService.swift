//
//  BaseService.swift
//  wan-android-iOS
//
//  Created by idt on 2020/6/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class BaseService: NSObject {
    public let httpClient: HttpClient
    
    override init() {
        self.httpClient = HttpClient.init(baseUrl: "https://www.wanandroid.com/", headers: nil)
    }
}
