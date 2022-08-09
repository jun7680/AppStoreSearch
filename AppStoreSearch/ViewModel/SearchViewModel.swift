//
//  LookUpViewModel.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

class SearchViewModel: NSObject {
    private let searhService = SearchService()
    
    var successAction: ((DetailData, [AppInfoType], [URL]) -> Void)?
    
    override init() {
        super.init()
    }
    
    func searchWithAppId(_ id: Int) {
        searhService.lookup(id: id) { [weak self] result, error in
            guard let self = self, error == nil else {
                // TODO: - error handling
                print(error)
                return
            }
            
            if let action = self.successAction, let result = result?.results.first {
                let detail = self.buildDetail(dto: result)
                let appInfoList = self.buildAppInfoTypes(dto: result)
                let screenShots = self.buildScreenShots(dto: result)
                action(detail, appInfoList, screenShots)
            }
        }
    }
    
    private func buildAppInfoTypes(dto: AppInfoDTO) -> [AppInfoType] {
        let rating = AppInfoType.rating(
            count: dto.userRatingCount,
            rating: round(dto.averageUserRating * 100) / 100
        )
        let advisory = AppInfoType.advisory(rating: dto.contentAdvisoryRating)
        let ranking = AppInfoType.ranking(rank: 1, category: dto.primaryGenreName)
        let developer = AppInfoType.developer(name: dto.sellerName)
        let primaryLang = dto.languageCodesISO2A.filter {
            $0.uppercased() == Locale.current.languageCode?.uppercased()
        }.first ?? dto.languageCodesISO2A.first ?? String()
        let language = AppInfoType.language(code: primaryLang, count: dto.languageCodesISO2A.count - 1)
        
        return [rating, advisory, ranking, developer, language]
    }
    
    private func buildDetail(dto: AppInfoDTO) -> DetailData {
        let appIconURL = URL(string: dto.artworkUrl512)
        
        return DetailData(
            title: dto.trackName,
            subTitle: dto.primaryGenreName,
            imageURL: appIconURL,
            version: dto.version,
            date: dto.releaseDate,
            releaseNote: dto.releaseNotes
        )
    }
    
    private func buildScreenShots(dto: AppInfoDTO) -> [URL] {
        return dto.screenshotUrls.compactMap { URL(string: $0) }
    }
}
