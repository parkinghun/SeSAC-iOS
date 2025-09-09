//
//  WeatherDTO.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation

struct WeatherResultDTO: Decodable {
    let main: WeatherDTO
    let wind: WindDTO
}

extension WeatherResultDTO {
    var toModel: Weather {
        return Weather(self)
    }
}

struct WeatherDTO: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"

        case humidity
    }

}

struct WindDTO: Decodable {
    let speed: Double
}
