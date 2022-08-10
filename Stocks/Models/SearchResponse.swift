//
//  SearchResponse.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 8/10/22.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
    
}

struct SearchResult: Codable {
    var description: String
    var displaySymbol: String
    var symbol: String
    var type: String
}
