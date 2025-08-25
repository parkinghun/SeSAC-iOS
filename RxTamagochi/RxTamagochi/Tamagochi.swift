//
//  Tamagochi.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

enum TamagochiType: Codable, CaseIterable {
    case tingling
    case smile
    case twinkle
    case prepare
    
    var title: String {
        switch self {
        case .tingling:
            return "따끔따끔 다마고치"
        case .smile:
            return "방실방실 다마고치"
        case .twinkle:
            return "반짝반짝 다마고치"
        case .prepare:
            return "준비중이에요"
        }
    }
    
    var thumbnail: String {
        switch self {
        case .tingling:
            return "1-6"
        case .smile:
            return "2-6"
        case .twinkle:
            return "3-6"
        case .prepare:
            return "noImage"
        }
    }
    
    var description: String {
        switch self {
        case .tingling:
            return "저는 선인장 다마고치입니다. 키는 2cm 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!!!"
        case .smile:
            return "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은 있답니다 방실방실!"
        case .twinkle:
            return "저는 반짝반짝 다마고치입니당. 키는 60km 몸무게는100톤이에용\n성격은 호기심이 많답니다!\n열심히 잘 먹고 잘 클 자신은 있답니다. 반짝반짝 빛날게요"
        default: return ""
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
    
    var image: String {
        // level 이랑 같음 9~10 은 9로
        let lv = min(9, max(1, level))
        let tamagochi = {
            switch type {
            case .tingling: return 1
            case .smile: return 2
            case .twinkle: return 3
            default: return 0
            }
        }()
        
        return "\(tamagochi)-\(lv)"
    }
    
    init() {}
    
    init(name: String, type: TamagochiType, rice: Int, water: Int, level: Int) {
        self.name = name
        self.type = type
        self.rice = rice
        self.water = water
        self.level = level
    }
    
    init(type: TamagochiType) {
        self.type = type
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
