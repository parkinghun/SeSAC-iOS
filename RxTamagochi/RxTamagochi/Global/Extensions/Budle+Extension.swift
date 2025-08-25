//
//  Budle+Extension.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        
        guard let value = plistDict.object(forKey: "APIKey") as? String else {
            fatalError("Couldn't find key 'APIKey' in 'APIKey.plist'.")
        }
        return value
        
    }
}
