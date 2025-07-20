//
//  User.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//
  
import UIKit

struct User: Equatable {
    let name: String //유저 닉네임
    let image: String //유저 프로필
    
    var uiImage: UIImage? {
        return UIImage(named: image)
    }
}
