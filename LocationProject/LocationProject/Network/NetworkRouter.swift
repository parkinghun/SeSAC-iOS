//
//  NetworkRouter.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation

enum NetworkRouter {
    case weather
    
    var endPoint: URL? {
        nil
    }
    
    private var baseURL: String {
        ""
    }
}
