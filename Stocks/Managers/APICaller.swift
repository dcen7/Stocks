//
//  HapticsManager.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 8/9/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
            static let apiKey = "cbpvbk2ad3i9b8tf7ccg"
            static let sandboxApiKey = "sandbox_cbpsnr2ad3i9b8tf5tug"
            static let baseUrl = "https://finnhub.io/api/v1/"
        
    }
    
    private init() { }
    
    // MARK: - Public
    
    public func search(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        request(url: url(for: .search, queryparams: ["q": safeQuery]),
                expecting: SearchResponse.self,
                completion: completion)
    }
    
    // get stock info
    
    // search stocks
    
    // MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidUrl
        case noDataReturned
    }
    
    private func url(for endpoint: Endpoint, queryparams: [String: String] = [:]) -> URL? {
        // ?q=apple&token=cbpsnr2ad3i9b8tf5tu0
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        // add any parameter
        for (name, value) in queryparams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // convert query items to suffix string
        let queryString = queryItems.map {  "\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        
        urlString += "?" + queryString
        print(urlString)
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
