//
//  MarketDataResponse.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 8/17/22.
//

import Foundation

struct MarketDataResponse: Codable {
    let open: [Double]
    let close: [Double]
    let high: [Double]
    let low: [Double]
    let status: String
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String , CodingKey {
        case open = "o"
        case low = "l"
        case timestamps = "t"
        case close = "c"
        case status = "s"
        case high = "h"
    }
    
    var candleSticks: [CandleStick] {
        var result = [CandleStick]()
        
        for index in 0..<open.count {
            result.append(.init(
                data: Date(timeIntervalSince1970: timestamps[index]),
                high: high[index],
                low: low[index],
                open: open[index],
                close: close[index]))
        }
        let sortedData = result.sorted { $0.data < $1.data }
        
        return sortedData
    }
}

struct CandleStick {
    let data: Date
    let high: Double
    let low: Double
    let open: Double
    let close: Double
}
