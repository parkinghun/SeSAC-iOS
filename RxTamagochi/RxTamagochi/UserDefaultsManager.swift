//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/9/25.
//

import Foundation

//final class UserDefaultsManager {
//    static let shared = UserDefaultsManager()
//    private let defaults = UserDefaults.standard
//  
//    private init() { }
//    
//    func saveData<T: UserDefaultsStorable & Codable>(_ value: T) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(value) {
//            defaults.set(encoded, forKey: T.key)
//        }
//    }
//
//    func loadData<T: UserDefaultsStorable & Codable>(_ type: T.Type) -> T? {
//
//        guard let data = defaults.data(forKey: T.key),
//              let value = try? JSONDecoder().decode(T.self, from: data) else { return nil }
//        
//        return value
//    }
//    
//    func deleteData<T: UserDefaultsStorable>(_ type: T.Type) {
//        defaults.removeObject(forKey: T.key)
//    }
//}
