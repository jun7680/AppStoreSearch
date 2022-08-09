//
//  File.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import UIKit

extension UIImageView {
    func setImage(url: URL) {
        ImageCache.shared.caching(url: url) { [weak self] uiImage in
            DispatchQueue.main.async {
                self?.image = uiImage
            }
        }
    }
}
