//
//  LookUpViewModel.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

class SearchViewModel: NSObject {
    private let searhService = SearchService()
    
    var successAction: ((DetailData, [AppInfoType], [URL]) -> Void) = {_,_,_ in }
    var errorAction: (() -> Void) = {}
    var emptyAction: (() -> Void) = {}
    
    override init() {
        super.init()
    }
    
    func searchWithAppId(_ id: Int) {
        searhService.lookup(id: id) { [weak self] result, error in
            guard let self = self, error == nil else {
                self?.errorAction()
                return
            }
            if let result = result?.results.first {
                let detail = self.buildDetail(dto: result)
                let appInfoList = self.buildAppInfoTypes(dto: result)
                let screenShots = self.buildScreenShots(dto: result)
                self.successAction(detail, appInfoList, screenShots)
            } else {
                self.emptyAction()
            }
        }
    }
    
    // 앱 상세 정보들
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
    
    // 디테일 화면에서 보여줘야 하는 기본 정보들 뷰데이터로 변환
    private func buildDetail(dto: AppInfoDTO) -> DetailData {
        let appIconURL = URL(string: dto.artworkUrl512)
        
        return DetailData(
            title: dto.trackName,
            subTitle: dto.primaryGenreName,
            imageURL: appIconURL,
            version: dto.version,
            date: dto.releaseDate,
            releaseNote: dto.releaseNotes,
            description: dto.description
        )
    }
    
    private func buildScreenShots(dto: AppInfoDTO) -> [URL] {
        return dto.screenshotUrls.compactMap { URL(string: $0) }
    }
}
