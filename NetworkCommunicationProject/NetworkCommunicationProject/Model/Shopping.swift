//
//  Shopping.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import Foundation

struct ShoppingResult: Decodable {
    let items: [Shopping]
}

struct Shopping: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
    
    var formattedPrice: String? {
        return lprice.toFormattedDecimal()
    }
}
