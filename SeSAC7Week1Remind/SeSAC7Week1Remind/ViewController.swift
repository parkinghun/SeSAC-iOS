//
//  ViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Jack on 7/3/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func zodiacSignsTapped(_ sender: UIButton) {
        getZodiacSign(month: Int.random(in: 1...12))
    }
    
    func getZodiacSign(month: Int) {
        let zodiacSign: [Int: String] = [
            1: "염소", 2: "물병", 3: "물고기", 4: "양", 5: "황소", 6: "쌍둥이",
            7: "게", 8: "사자", 9: "처녀", 10: "천칭", 11: "전갈", 12: "사수"
        ]
        
        let sign = zodiacSign[month] ?? ""
        resultLabel.text = "\(month)월은 \(sign)자리입니다."
    }
    
    @IBAction func recommandGameJob(_ sender: UIButton) {
        let strength = Int.random(in: 1...100)
        let agility = Int.random(in: 1...100)
        getRecommandGameJob(strength: strength, agility: agility)
    }
    
    func getRecommandGameJob(strength: Int, agility: Int) {
        
        //여기에 코드를 작성해주세요
        //힘(strength)이 높으면 전사, 민첩(agility)이 높으면 도적, 같다면 마법사 추천
        let abilities: String
        let job: String
        
        if strength > agility {
            abilities = "strength(힘)"
            job = "전사"
        } else if strength == agility {
            abilities = "strength(힘) 와 agility(민첩)"
            job = "마법사"
        } else {
            abilities = "agility(민첩)"
            job = "도적"
        }
        
        resultLabel.text = "\(abilities)이 가장 높으니 \(job)를 추천드립니다."
    }
    
    @IBAction func recommandClothing(_ sender: UIButton) {
        let temp = Int.random(in: -30...50)
        let rain = Bool.random()
        
        getRecommandClothing(temperature: temp, isRaining: rain)
    }
    
    func getRecommandClothing(temperature: Int, isRaining: Bool) {

        //여기에 코드를 작성해주세요
        //영하~10도라면 페딩을 입으세요, 10도~20도 긴팔을 입으세요, 20~30도 반팔을 입으세요, 30도 이상 나가지마세요
        //비가 온다면 우산을 챙기세요
        let clothes: String
        let isRain = isRaining ? "비가 오고있으니 우산 챙기세요." : "비가 오지 않으니 우산은 안챙겨도 됩니다. "
        
        switch temperature {
        case ...10: clothes = "패딩을 입으세요"
        case 11...20: clothes = "긴팔을 입으세요"
        case 21...30: clothes = "반팔을 입으세요"
        case 31...: clothes = "나가지 마세요"
        default: clothes = ""
        }
        
        resultLabel.text = """
                            지금 온도가 \(temperature)도 이니 \(clothes). 
                            \(isRain)  
                            """
    }
    
    @IBAction func evaluateGrade(_ sender: UIButton) {
        let data = [3, 27, 64, 89, 7, 12, 45, 78, 14, 29, 56, 92, 1, 33, 67, 85, 9, 21, 48, 76, 18, 41, 63, 94, 5, 30, 52, 87, 11, 26, 59, 81, 15, 37, 70, 96, 2, 34, 61, 83, 8, 23, 49, 90, 17, 39, 65, 98, 4, 28, 53, 79, 12, 36, 68, 91, 6, 31, 57, 84, 19, 42, 66, 95, 10, 25, 51, 88, 16, 38, 60, 97, 13, 32, 55, 82, 20, 44, 69, 93, 3, 29, 62, 86, 7, 35, 58, 80, 14, 40, 64, 99, 1, 24, 50, 77, 9, 33, 67, 92, 18, 46, 71, 85, 5, 27, 54, 89, 11, 39, 63, 96, 15, 34, 59, 81, 2, 30, 65, 94, 8, 41, 68, 87, 17, 37, 52, 90, 4, 26, 61, 83, 12, 43, 70, 98, 6, 28, 56, 79, 19, 45, 66, 91, 10, 32, 58, 84, 16, 40, 62, 95, 13, 25, 51, 88, 20, 38, 69, 97, 3, 31, 57, 82, 7, 36, 64, 93, 14, 29, 50, 86, 1, 42, 67, 80, 9, 34, 61, 99, 18, 27, 55, 92, 5, 39, 68, 85, 11, 33, 60, 94, 15, 46, 71]
        
        //여기에 코드를 작성해주세요
        let studentCount = data.count
        let sum = data.reduce(0, +)
        let average = calculateAverage(sum, count: studentCount)
        
        resultLabel.text = "\(studentCount)명의 평균 점수는 \(average)점입니다."
    }
    
    private func calculateAverage(_ sum: Int, count: Int) -> Double {
        let average = Double(sum) / Double(count)
        return (average * 100).rounded() / 100
    }

    @IBAction func countFruits(_ sender: UIButton) {
        let fruits = ["체리", "딸기", "사과", "멜론", "망고", "오렌지", "오렌지", "키위", "딸기", "사과", "복숭아", "포도", "배", "바나나", "오렌지", "배", "포도", "참외", "사과", "블루베리", "오렌지", "오렌지", "바나나", "사과", "수박", "포도", "딸기", "체리", "사과", "자두", "멜론", "멜론", "수박", "파인애플", "참외", "참외", "바나나", "멜론", "사과", "사과", "자두", "딸기", "바나나", "석류", "라임", "키위", "자두", "사과", "오렌지", "자두", "레몬", "바나나", "사과", "수박", "체리", "사과", "블루베리", "딸기", "바나나", "수박", "체리", "사과", "복숭아", "수박", "참외", "오렌지", "바나나", "참외", "오렌지", "바나나", "체리", "딸기", "바나나", "감", "감", "키위", "자두", "포도", "파인애플", "포도", "사과", "포도", "블루베리", "포도", "바나나", "사과", "망고", "복숭아", "레몬", "사과", "자두", "복숭아", "포도", "오렌지", "오렌지", "수박", "망고", "사과", "블루베리", "감", "바나나", "딸기", "바나나"]
        
        //여기에 코드를 작성해주세요
        
        resultLabel.text = countFruits(fruits)
    }
    
    private func countFruits(_ fruits: [String]) -> String {
        var fruitsDic: [String: Int] = [:]
        var text: String = ""
        
        fruits.forEach { fruitsDic[$0, default: 0] += 1 }
        fruitsDic.forEach { text += "\($0.key): \($0.value)개, " }
        return text
    }
     
    
}

