//
//  Shopping.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/10/25.
//

import UIKit

struct ShoppingData: Identifiable {
    let id = UUID()
    let todo: String
    var isPurchased: Bool
    var isFavorite: Bool
    
    init(todo: String, isPurchased: Bool = .random(), isFavorite: Bool = .random()) {
        self.todo = todo
        self.isPurchased = isPurchased
        self.isFavorite = isFavorite
    }
                                            
    var pushasedImage: UIImage? {
        return UIImage(systemName: isPurchased ? "checkmark.square.fill" : "checkmark.square")
    }
    
    var favoriteImage: UIImage? {
        return UIImage(systemName: isFavorite ? "star.fill" : "star" )
    }
}
