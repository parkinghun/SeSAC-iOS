//
//  Weather.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation

struct Weather {
    let temp: String
    let tempMin: String
    let tempMax: String
    let humidity: String
    let windSpped: String
    
    init(_ dto: WeatherResultDTO) {
        self.temp = "\(dto.main.temp)°C"
        self.tempMin = "\(dto.main.tempMin)°C"
        self.tempMax = "\(dto.main.tempMax)°C"
        self.humidity = "\(dto.main.humidity)%"
        self.windSpped = "\(dto.wind.speed)m/s"
    }
    
}
