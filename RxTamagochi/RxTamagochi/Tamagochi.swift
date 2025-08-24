//
//  Tamagochi.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

enum TamagochiType: Codable {
    case tingling
    case smile
    case twinkle
    
    var title: String {
        switch self {
        case .tingling:
            return "따끔따끔 다마고치"
        case .smile:
            return "방실방실 다마고치"
        case .twinkle:
            return "반짝반짝 다마고치"
        }
    }
}

// userDefaults에 저장될 내용
struct Tamagochi: Codable, Equatable {
    
    var name: String = "대장"
    var type: TamagochiType = .smile
    var rice: Int = 0
    var water: Int = 0
    var level: Int = 1
    
    init() {}
    
    init(name: String, type: TamagochiType, rice: Int, water: Int, level: Int) {
        self.name = name
        self.type = type
        self.rice = rice
        self.water = water
        self.level = level
    }
    
    private var messageList: [String] {[
        "\(name)님 안녕하세요",
        "\(name)님, 밥주세요",
        "\(name)님, 물주세요",
        "좋은 하루에요, \(name)님",
        "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(name)님",
        "\(name)님 잘자요",
        "복습 아직 안하셨다구요? 지금 잠이 오세여? \(name)님???"
    ]}
    
    var randomMessage: String {
        messageList.randomElement() ?? "\(name)님 안녕하세요"
    }
    
    static let dummy = Tamagochi(name: "", type: .smile, rice: 0, water: 0, level: 0)
}
