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

extension UIImage {
    // image resize 함수
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
