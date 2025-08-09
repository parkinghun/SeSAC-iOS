//
//  BirthdayViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class BirthdayViewModel {
    typealias BirthResult = Result<String, BirthDayValidationError>
    var closure: (() -> Void)?
    
    var inputBirth: Birth = .init(year: "", month: "", day: "") {
        didSet {
            outputResult = validateBirthDayInput()
        }
    }
    
    var outputText: String = ""
    var outputShowAlert = false
    
    private var outputResult: BirthResult = .success("") {
        didSet {
            setupOutput(result: outputResult)
            closure?()
        }
    }
    
    private func setupOutput(result: BirthResult) {
        do {
            outputText = try outputResult.get()
            outputShowAlert = false
        } catch let error {
            outputText = error.message
            outputShowAlert = true
        }
    }
    
    private func validateBirthDayInput() -> BirthResult {
        guard let year = inputBirth.year, let month = inputBirth.month, let day = inputBirth.day else {
            return BirthResult.failure(.validateError)
        }
        
        do {
            let _ = try validateBirthDayInput(year: year, month: month, day: day)
            let gap = try calculateDateGap(birth: inputBirth.date)
            
            return BirthResult.success("D+\(gap)")
        } catch let error {
            return BirthResult.failure(error)
        }
    }
    
    private func validateBirthDayInput<T: StringProtocol>(year: T, month: T, day: T) throws(BirthDayValidationError) {
        guard !year.isEmpty, !month.isEmpty, !day.isEmpty else {
            throw .blankSpace
        }
        
        guard let year = Int(year), let month = Int(month), let day = Int(day) else {
            throw .isNotNumber
        }
        
        guard (inputBirth.yearLimit.min...inputBirth.yearLimit.max).contains(year) else {
            throw .outOfYear
        }
        
        guard (inputBirth.monthLimit.min...inputBirth.monthLimit.max).contains(month) else {
            throw .outOfMonth
        }
        
        guard (inputBirth.dayLimit.min...inputBirth.dayLimit.max).contains(day) else {
            throw .outOfDay
        }
    }
    
    private func calculateDateGap(birth: Date?) throws(BirthDayValidationError) -> Int {
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
