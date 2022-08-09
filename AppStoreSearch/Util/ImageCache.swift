//
//  ImageCache.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func caching(url: URL, block: @escaping (UIImage?) -> Void) {
        let key = NSString(string: url.absoluteString)
        if let image = cache.object(forKey: key) {
            block(image)
        }
        
        requestImage(url: url) { [weak self] data in
            guard let data = data else {
                block(nil)
                return
            }

            if let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: key)
                block(image)
            } else {
                block(nil)
            }
        }
    }
    
    private func requestImage(url: URL, block: @escaping (Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) {data, response, error in
                block(data)
            }.resume()
        }
    }
}
