//
//  Bundle+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/24/25.
//

import Foundation

extension Bundle {
    
    static func getAPIKey(for key: APIKeyType) -> String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        
        guard let value = plistDict.object(forKey: key.rawValue) as? String else {
            fatalError("Couldn't find key '\(key.rawValue)' in 'Info.plist'.")
        }
        
        return value
    }
    
    enum APIKeyType: String {
        case movie = "MovieKey"
        case naverClientID = "NaverClientID"
        case naverClientSecret = "NaverClientSecret"
        
    }
}
