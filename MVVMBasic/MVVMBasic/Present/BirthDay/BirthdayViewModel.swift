//
//  BirthdayViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class BirthdayViewModel {
    typealias BirthResult = Result<String, BirthDayValidationError>
    
    var inputBirth = Observable(Birth(year: "", month: "", day: ""))
    var outputResult = Observable(BirthResult.success(""))
    
    init() {
        inputBirth.bind { [weak self] _ in
            guard let self else { return }
            outputResult.value = validateResult(birth: inputBirth.value)
        }
    }
}

private extension BirthdayViewModel {
    func validateResult(birth: Birth) -> BirthResult {
        do {
            let _ = try validateBirthDayInput(birth: birth)
            let gap = try calculateDateGap(birth: birth.date)
            return .success("D+\(gap)")
        } catch let error {
            return .failure(error)
        }
    }
    
    func validateBirthDayInput(birth: Birth) throws(BirthDayValidationError) -> Void {
        guard let year = birth.year, let month = birth.month, let day = birth.day else {
            throw BirthDayValidationError.validateError
        }
        
        guard !year.isEmpty, !month.isEmpty, !day.isEmpty else {
            throw BirthDayValidationError.blankSpace
        }
        
        guard let year = Int(year), let month = Int(month), let day = Int(day) else {
            throw BirthDayValidationError.isNotNumber
        }
        
        guard (birth.yearLimit.min...birth.yearLimit.max).contains(year) else {
            throw BirthDayValidationError.outOfYear
        }
        
        guard (birth.monthLimit.min...birth.monthLimit.max).contains(month) else {
            throw BirthDayValidationError.outOfMonth
        }
        
        guard (birth.dayLimit.min...birth.dayLimit.max).contains(day) else {
            throw BirthDayValidationError.outOfDay
        }
    }
    
    func calculateDateGap(birth: Date?) throws(BirthDayValidationError) -> Int {
        guard let birth,
              let gap = Calendar.current.getDateGap(from: birth) else {
            throw .isNotDate
        }
        
        return gap
    }
}

extension BirthdayViewModel {
    struct Birth {
        var year: String?
        var month: String?
        var day: String?
        
        var date: Date? {
            guard let year, let month, let day,
                  let yearInt = Int(year), let monthInt = Int(month), let dayInt = Int(day) else { return nil }
            let formattedYear = String(format: "%04d", yearInt)
            let formatteMonth = String(format: "%02d", monthInt)
            let formatteDay = String(format: "%02d", dayInt)
            let dateString = formattedYear + formatteMonth + formatteDay
            return DateFormatter.simpleFormatter.date(from: dateString)
        }
        
        var yearLimit: (min: Int, max: Int) {
            return (0, 2025)
        }
        var monthLimit: (min: Int, max: Int) {
            return (1, 12)
        }
        var dayLimit: (min: Int, max: Int) {
            return (1, 31)
        }
    }
    
    enum BirthDayValidationError: Error {
        case outOfYear
        case outOfMonth
        case outOfDay
        case isNotNumber
        case blankSpace
        case isNotDate
        case validateError
        
        var message: String {
            switch self {
            case .outOfYear:
                return "입력하신 정보가 년도의 범위를 벗어났습니다."
            case .outOfMonth:
                return "입력하신 정보가 달의 범위를 벗어났습니다."
            case .outOfDay:
                return "입력하신 정보가 날짜 범위를 벗어났습니다."
            case .isNotNumber:
                return "숫자가 아닙니다. 모두 숫자로 입력해주세요."
            case .blankSpace:
                return "생년월일을 모두 입력해주세요."
            case .isNotDate:
                return "날짜를 생성할 수 없습니다."
            case .validateError:
                return "잘못된 입력정보 입니다. 다시 입력해주세요."
            }
        }
    }
}
