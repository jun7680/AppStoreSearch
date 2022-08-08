//
//  APIType.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

protocol APIType {
    var baseURL: URL { get }
    var path: String { get }
    var params: [String: Any] { get }
}
