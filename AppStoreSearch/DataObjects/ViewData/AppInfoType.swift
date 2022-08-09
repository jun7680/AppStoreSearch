//
//  AppInfoType.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import Foundation

enum AppInfoType {
    case rating(count: Int, rating: Double)
    case advisory(rating: String)
    case ranking(rank: Int, category: String)
    case developer(name: String)
    case language(code: String, count: Int)
}
