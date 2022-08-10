//
//  TextUtil.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import Foundation

class TextUtil {
    static func unitFormatted(_ num: Int) -> String {
        switch num {
        case 1000..<10000:
            return String(format: "%.1f천", Double(num) / 1000)
        case 10000..<100000:
            return String(format: "%.1f만", Double(num) / 10000)
        case 100000..<Int.max:
            return String(format: "%d만", num / 10000)
        default:
            return num.description
        }
    }
}
