//
//  Chat.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation
//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    let message: String
    
    static func makeNewChat(message: String) -> Chat {
        return Chat(user: ChatList.me, date: Date().hourDateString, message: message)
    }
    
    var formattedtTime: String? {
        return date.toFormattedTime()
    }
    
    var formattedDate: String? {
        return date.toFormattedFullDate()
    }
}
