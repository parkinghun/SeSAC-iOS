//
//  Game.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/22/25.
//

import Foundation

struct Game {
    var gameState = GameState.none
    let inputNumber: Int
    let randomNumber: Int
    var numberArray: [Int]
    var selectedNumber: Int = 0
    var count: Int = 0
    
    init(inputNumber: Int, randomNumber: Int) {
        self.inputNumber = inputNumber
        self.randomNumber = randomNumber
        self.numberArray = Array(1...inputNumber)
    }
    
    mutating func updateGame() {
        if selectedNumber == randomNumber {
            gameState = .bingo
            numberArray = [randomNumber]
        } else if selectedNumber > randomNumber  {
            gameState = .down
            numberArray.removeAll(where: { $0 >= selectedNumber })
        } else {
            gameState = .up
            numberArray.removeAll(where: { $0 <= selectedNumber })
        }
        print(numberArray)
        count += 1
    }
}

extension Game {
    enum GameState: String {
        case none = "UP DOWN"
        case bingo = "Good"
        case up = "UP"
        case down = "DOWN"
    }
}
