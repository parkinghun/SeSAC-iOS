//
//  City.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/23/25.
//

import Foundation

struct City: Hashable, Identifiable {
    let id = UUID()
    let cityName: String
    let cityEnglishName: String
    let cityExplain: String
    let cityImage: String
    let domesticTravel: Bool
    
    init(city_name cityName: String, city_english_name cityEnglishName: String, city_explain cityExplain: String, city_image cityImage: String, domestic_travel domesticTravel: Bool) {
        self.cityName = cityName
        self.cityEnglishName = cityEnglishName
        self.cityExplain = cityExplain
        self.cityImage = cityImage
        self.domesticTravel = domesticTravel
    }
    
    var nameLabelText: String {
        return "\(cityName) | \(cityEnglishName)"
    }
    
    var cityImageURL: URL? {
        return URL(string: cityImage)
    }
}
