//
//  LookUpAPI.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

enum SearchAPI: APIType {
    case detail(appID: Int)
}

extension SearchAPI {
    var baseURL: URL {
        URL(string: "http://itunes.apple.com/")!
    }
    
    var path: String {
        switch self {
        case .detail:
            return "lookup"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .detail(let appID):
            return [
                "id": appID
            ]
        }
    }
}
