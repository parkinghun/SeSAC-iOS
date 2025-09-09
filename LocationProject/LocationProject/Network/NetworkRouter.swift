//
//  NetworkRouter.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case weather(lat: Double, lon: Double)
    
    var endPoint: URL? {
        return URL(string: baseURL)
    }
    
    private var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/weather"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameter {
        switch self {
        case let .weather(lat, lon):
            return Parameter(lat: lat, lon: lon)
        }
    }
    
    struct Parameter: Encodable {
        var lat: Double
        var lon: Double
        var appid: String = Bundle.getSecrets(for: .key)
        var units: String = "metric"
        var lang: String = "kr"
    }
}

