//
//  MyChatCollectionViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

final class MyChatCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: MyChatCollectionViewCell.self)
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurUI()
    }
    
    func configure(item: Chat) {
        messageLabel.text = item.message
        dateLabel.text = item.formattedtTime
    }
    
    private func configurUI() {
        bgView.configure(cornerRadius: 12, bgColor: .systemGray5, borderWidth: 1, borderColor: UIColor.gray.cgColor)
        messageLabel.numberOfLines = 0
        dateLabel.configure(color: .gray)
    }

}
