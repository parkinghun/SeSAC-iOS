//
//  Travel.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit

struct Travel {
    var title: String
    var description: String?
    var travel_image: String?
    var grade: Double?
    var save: Int?
    var like: Bool?
    var likeCount = Int.random(in: 1...3000)
    var ad: Bool?
    
    var likeImage: UIImage? {
        return UIImage(systemName: (like ?? false) ? "heart" : "heart.fill")
    }
    
    var imageURL: URL? {
        return URL(string: travel_image ?? "")
    }
    
    var adBgColor: UIColor? {
        let color: [UIColor] = [.systemPink, .green, .orange, .cyan, .magenta]
        return color.randomElement()
    }
    
    var saveText: String {
        return "(\(formattedNumber(likeCount))) ∙ 저장 \(formattedNumber(save))"
    }
    
    func formattedNumber(_ number: Int?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number else { return "0" }
        return numberFormatter.string(for: number) ?? "0"
    }
    

}
