//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum BirthDayValidationError: Error {
    case outOfYear
    case outOfMonth
    case outOfDay
    case isNotNumber
    case blankSpace
    case isNotDate
    
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
        }
    }
}

struct Birth {
    var year: String
    var month: String
    var day: String
    
    var date: Date? {
        DateFormatter.simpleFormatter.date(from: year + month + day)
    }
}

class BirthDayViewController: UIViewController {
    
    var birth = Birth(year: "", month: "", day: "")

    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        
        guard let year = yearTextField.text,
              let month = monthTextField.text,
              let day = dayTextField.text else { return }
        
        do {
            let birthTuple = try validateBirthDaynput(year: year, month: month, day: day)
            self.birth = getBirthString(year: birthTuple.year, month: birthTuple.month, day: birthTuple.day)
            
            let gap = try calculateDate(birth: birth.date)
            
            resultLabel.text = "D+\(gap)"
        } catch let error {
            resultLabel.text = "입력 에러! 다시 입력해주세요."
            showAlert(title: "입력 에러", message: error.message)
        }
        
        resetInput()
        view.endEditing(true)
    }
    
    private func resetInput() {
        yearTextField.text = ""
        monthTextField.text = ""
        dayTextField.text = ""
        
        yearTextField.becomeFirstResponder()
    }
    
    private func validateBirthDaynput<T: StringProtocol>(year: T, month: T, day: T) throws(BirthDayValidationError) -> (year: Int, month: Int, day: Int) {
        guard !year.isEmpty, !month.isEmpty, !day.isEmpty else {
            throw .blankSpace
        }
        
        guard let year = Int(year),
              let month = Int(month),
              let day = Int(day) else {
            throw .isNotNumber
        }
        
        guard year >= 1, year <= 2025 else {  // 0 2026 해보기
            throw .outOfYear
        }
        
        guard month >= 1, month <= 12 else {
            throw .outOfMonth
        }
        
        guard day >= 1, day <= 31 else {
            throw .outOfDay
        }
        
        return (year, month, day)
    }
    
    private func getBirthString(year: Int, month: Int, day: Int) -> Birth {
        birth.year = String(format: "%04d", year)
        birth.month = String(format: "%02d", month)
        birth.day = String(format: "%02d", day)
        return birth
    }
    
    private func calculateDate(birth: Date?) throws(BirthDayValidationError) -> Int {
        guard let birth else {
            throw .isNotDate
        }
        
        let gap = Calendar.current.getDateGap(from: birth, to: .now)
        return gap
    }
    
    
}
