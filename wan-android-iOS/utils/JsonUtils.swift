//
//  JsonUtils.swift
//  wan-android-iOS
//
//  Created by idt on 2020/6/22.
//  Copyright © 2020 肖楚🐑. All rights reserved.
//

import Foundation
class JsonUtils: NSObject {

    public static func jsonParse<T:Codable>(jsonStr: String) -> T? {
        guard let jsonData = jsonStr.data(using: .utf8) else {
            return nil
        }
        let result: T? = try? JSONDecoder.init().decode(T.self, from: jsonData)
        return result
    }

    public static func toJsonString(any: Any) -> String {
        //首先判断能不能转换
        guard JSONSerialization.isValidJSONObject(any) else {
            return ""
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: any, options: [])
        if let jsonData = jsonData {
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            return str ?? ""
        } else {
            return ""
        }
    }

}
