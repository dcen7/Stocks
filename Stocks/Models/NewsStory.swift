//
//  NewStory.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 8/15/22.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}