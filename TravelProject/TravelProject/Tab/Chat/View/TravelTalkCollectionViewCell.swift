//
//  TravelTalkCollectionViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/19/25.
//

import UIKit

final class TravelTalkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImageView.configure(cornerRadius: profileImageView.frame.width / 2, contentMode: .scaleAspectFill)
    }
    
    func configure(item: ChatRoom) {
        profileImageView.image = item.chatRoomUIImage
        nameLabel.text = item.chatroomName
        lastMessageLabel.text = item.lastMessage
        dateLabel.text = item.formattedLastDate
    }
    
    private func configureUI() {
        profileImageView.clipsToBounds = true
        nameLabel.font = .boldSystemFont(ofSize: 16)
        lastMessageLabel.textColor = .gray
        dateLabel.textColor = .gray
    }
}
