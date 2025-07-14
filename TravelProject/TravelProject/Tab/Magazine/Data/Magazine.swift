//
//  Magazone.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import Foundation

struct Magazine {
    let title: String
    let subtitle: String
    let photo_image: String
    let date: String
    let link: String
    
    var imageUrl: URL? {
        return URL(string: photo_image)
    }
}
