//
//  Tamagochi.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import Foundation

enum TamagochiType {
    case smile
    
    var title: String {
        switch self {
        case .smile:
            return "방실방실 다마고치"
        }
    }
   
}

// userDefaults에 저장될 내용
class Tamagochi {
    var name: String = "대장님"
    var type: TamagochiType = .smile
    var rice: Int = 0
    var water: Int = 0
    var level: Int = 1
    
    init(name: String, type: TamagochiType, rice: Int, water: Int, level: Int) {
        self.name = name
        self.type = type
        self.rice = rice
        self.water = water
        self.level = level
    }
}
