//
//  MBTIViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class MBTIViewModel {
    var selectedEnergy: EnergyType?
    var selectedPerception: PerceptionType?
    var selectedJudgment: JudgmentType?
    var selectedLifeStyle: LifestyleType?

    
}

extension MBTIViewModel {
    enum EnergyType: String, CaseIterable {
        case e = "E"
        case i = "I"
    }
    
    enum PerceptionType: String, CaseIterable {
        case s = "S"
        case n = "N"
    }
    
    enum JudgmentType: String, CaseIterable {
        case t = "T"
        case f = "F"
    }
    
    enum LifestyleType: String, CaseIterable {
        case j = "J"
        case p = "P"
    }
}

