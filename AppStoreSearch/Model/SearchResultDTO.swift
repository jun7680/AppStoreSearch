//
//  AppSearhResultDTO.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

struct SearchResultDTO: Codable {
    let resultCount: Int?
    let results: [Result]?
}

struct Result: Codable {
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let appletvScreenshotsUrls: [String]?
    let artworkUrl60: String?
    let artworkUrl512: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let supportedDevices: [String]?
    let features: [String]?
    let isGameCenterEnabled: Bool?
    let advisories: [String]?
    let kind: String?
    let artistId: Int?
    let artistName: String?
    let genres: [String]?
    let price: Int?
    let description: String?
    let minimumOsVersion: String?
    let trackCensoredName: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String?
    let averageUserRatingForCurrentVersion: Double?
    let userRatingCountForCurrentVersion: Int?
    let trackViewUrl: String?
    let trackContentRating: String?
    let primaryGenreName: String?
    let primaryGenreId: Int?
    let genreIds: [String]?
    let currentVersionReleaseDate: String?
    let releaseDate: String?
    let averageUserRating: Double?
    let trackId: Int?
    let trackName: String?
    let sellerName: String?
    let releaseNotes: String?
    let bundleId: String?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let version: String?
    let wrapperType: String?
    let currency: String?
    let userRatingCount: Int?
}
