//
//  WanResponse.swift
//  wan-android-iOS
//
//  Created by 肖楚🐑 on 2020/7/4.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation

class WanResponse<T>: NSObject, Codable where T: Codable {
    let errorCode: Int
    let errorMsg: String
    let data: T?

    enum CodingKeys: String, CodingKey {
        case errorCode
        case errorMsg
        case data
    }

    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try c.decode(Int.self, forKey: .errorCode)
        errorMsg = try c.decode(String.self, forKey: .errorMsg)
        data = try c.decodeIfPresent(T.self, forKey: .data)
    }

    init(errorCode: Int, errorMsg: String, data: T?) {
        self.errorCode = errorCode
        self.errorMsg = errorMsg
        self.data = data
    }
}
