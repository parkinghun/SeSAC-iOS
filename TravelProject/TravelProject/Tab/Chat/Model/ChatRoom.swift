//
//  ChatRoom.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import UIKit

//트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: String //채팅방 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
    
    var chatRoomUIImage: UIImage? {
        return UIImage(named: chatroomImage)
    }
    
    var lastMessage: String? {
        return chatList.last?.message
    }
    
    var formattedLastDate: String? {
        return chatList.last?.date.toFormattedShortDate()
    }
}
