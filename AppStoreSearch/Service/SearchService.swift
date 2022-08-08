//
//  SearchService.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

protocol SearchServiceType {
    func lookup(id: Int, completion: @escaping (SearchResultDTO?, Error?) -> Void)
}

// api 통신을 위한 서비스 클래스
class SearchService: SearchServiceType {
    func lookup(id: Int, completion: @escaping (SearchResultDTO?, Error?) -> Void) {
        let apiType = SearchAPI.detail(appID: id)
        return SessionManager.shared.request(apiType: apiType, completion: completion)
    }
}
