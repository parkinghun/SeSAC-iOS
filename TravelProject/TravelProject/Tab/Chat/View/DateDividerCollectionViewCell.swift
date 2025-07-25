//
//  DateDividerCollectionViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

final class DateDividerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var calendarImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configure(date: String) {
        dateLabel.text = date.toFormattedFullDate()
    }
    
    private func configureUI() {
        calendarImageView.image = UIImage(systemName: "calendar")
        calendarImageView.tintColor = .white
        dateLabel.configure(font: .systemFont(ofSize: 12), color: .white)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        bgView.configure(cornerRadius: bgView.frame.height / 2, bgColor: .black)
    }
}
