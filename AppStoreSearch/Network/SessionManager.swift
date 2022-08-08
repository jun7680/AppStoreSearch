//
//  SessionManager.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import Foundation

enum NetworkError: Error {
    case notResponse
    case invalidParam
}

class SessionManager {
    static let shared = SessionManager()
    
    private let session = URLSession.shared
    
    func request<T: Codable>(apiType: APIType, completion: @escaping (T?, Error?) -> Void) {
        guard let componetns = self.urlComponents(apiType: apiType),
              let url = componetns.url
        else {
            completion(nil, NetworkError.invalidParam)
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            do {
                let successRange = 200..<300
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                
                if !successRange.contains(statusCode), let error = error {
                    throw error
                }
                
                // 성공은 했지만 data가 비어있을때 error
                guard let data = data else {
                    throw NetworkError.notResponse
                }
                
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    private func urlComponents(apiType: APIType) -> URLComponents? {
        var url = apiType.baseURL.appendingPathComponent(apiType.path).absoluteString
        
        let queryItems = apiType.params.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        if !queryItems.isEmpty {
            url += "?"
        }
        
        var components = URLComponents(string: url)
        components?.queryItems?.append(contentsOf: queryItems)
        
        return components

    }
}
