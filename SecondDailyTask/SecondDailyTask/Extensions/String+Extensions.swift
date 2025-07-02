//
//  String+Extensions.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import Foundation

extension String{
    var isValidEmail: Bool {
        let regExp = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$" //"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        //TODO: - swift5.7 정규식 찾아보기
        return NSPredicate(format: "SELF MATCHES %@", regExp).evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let regex = "^01[0-1, 7][0-9]{7,8}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,13}" // 8자리 ~ 13자리 영어+숫자+특수문자

        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    var isValidCode: Bool {
        let regex = "^[a-zA-Z]{6}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    
}
