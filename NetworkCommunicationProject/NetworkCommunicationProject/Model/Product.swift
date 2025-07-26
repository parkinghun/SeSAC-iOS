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
        return NumberFormatter.decimalFormatter.string(for: total)
    }
}

struct Product: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
    
    var formattedPrice: String? {
        guard let price = Int(lprice) else { return nil }
        return NumberFormatter.decimalFormatter.string(for: price)
    }
    
    var imageURL: URL? {
        return URL(string: image)
    }
}
