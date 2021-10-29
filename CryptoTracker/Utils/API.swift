//
//  API.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 29/10/21.
//

import Foundation

enum API {
    case finnhub
    case gecko
    
    var baseURL: String {
        switch self {
        case .finnhub:
            return "https://finnhub.io/api/v1"
        case .gecko:
            return "https://api.coingecko.com/api/v3"
        }
    }
    
    var token: String {
        switch self {
        case .finnhub:
            return "c5tigt2ad3ifck7dghmg"
        case .gecko:
            return ""
        }
    }
}
