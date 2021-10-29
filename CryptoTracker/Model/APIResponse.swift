//
//  APIResponse.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 28/10/21.
//

import Foundation

struct APIResponse: Codable {
    var data: [PriceData]
    var type: String
    
    private enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

struct PriceData: Codable{
    public var p: Float
    
    private enum CodingKeys: String, CodingKey {
        case p
    }
}
