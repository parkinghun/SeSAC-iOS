//
//  OhtersChatCollectionViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

final class OhtersChatCollectionViewCell: UICollectionViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageBgView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImageView.configure(cornerRadius: profileImageView.frame.width / 2, contentMode: .scaleAspectFill)
    }

    func configure(item: Chat) {
        profileImageView.image = item.user.uiImage
        nameLabel.text = item.user.name
        messageLabel.text = item.message
        dateLabel.text = item.formattedtTime
    }
    
    private func configureUI() {
        messageLabel.numberOfLines = 0
        messageBgView.configure(cornerRadius: 12, borderWidth: 1, borderColor: UIColor.gray.cgColor)
        dateLabel.configure(font: .systemFont(ofSize: 12), color: .gray)
    }
}
