//
//  LookUpViewModel.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

class SearchViewModel: NSObject {
    private let searhService = SearchService()
    
    var successAction: ((SearchResultDTO) -> Void)?
    
    override init() {
        super.init()
    }
    
    func searchWithAppId(_ id: Int) {
        searhService.lookup(id: id) { result, error in
            guard error == nil else {
                // TODO: - error handling
                return
            }
            
            if let action = self.action, let result = result {
                action(result)
            }
        }
    }
}
