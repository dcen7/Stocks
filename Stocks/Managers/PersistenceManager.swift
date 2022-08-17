//
//  PersistenceManager.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 8/9/22.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchlistKey = "watchlist"
    }
    
    private init() { }
    
    // MARK: - Public
    
    public var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchlistKey) ?? []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeFromWatchlist() {
        
    }
    
    // MARK: - Private
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    private func setUpDefaults() {
        let map: [String: String] = [
            "AAPL" : "Apple Inc.",
            "MFST" : "Microsoft Corporation",
            "SNAP" : "Snap Inc",
            "GOOG" : "Alphabet",
            "AMZN" : "Amazon.com, Inc.",
            "WORK" : "Slack Technologies",
            "FB"   : "Facebook Inc.",
            "NVDA" : "Nvidia Inc.",
            "NKE" : "Nike",
            "PINS" : "Pinterest Inv."
        ]
        
        let symbols = map.keys.map { $0 }
        
        userDefaults.set(symbols, forKey: Constants.watchlistKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol)
        }
    }
}
