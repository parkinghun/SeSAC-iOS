//
//  Shopping.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let items: [Product]
    
    var formattedCount: String? {
        return total.formatted()
    }
}

struct Product: Decodable, Equatable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
    
    var formattedPrice: String? {
        guard let price = Int(lprice) else { return nil }
        return "\(price.formatted())원"
    }
    
    var imageURL: URL? {
        return URL(string: image)
    }
}

struct ShoppingErrorEntity: Decodable {
    let errorMessage: String
    let errorCode: String
}
