//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/9/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private enum Key {
        static let tamagochi = "tamagochi"
    }
    
    private init() {}
    
    func saveTamagochi(_ tamagochi: Tamagochi) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tamagochi) {
            defaults.set(encoded, forKey: Key.tamagochi)
        }
    }

    func loadTamagochi() -> Tamagochi? {
        guard let data = defaults.data(forKey: Key.tamagochi) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Tamagochi.self, from: data)
    }
}
