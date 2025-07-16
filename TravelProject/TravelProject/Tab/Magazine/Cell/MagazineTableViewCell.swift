//
//  MagazineTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    static let id = "MagazineTableViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        configurelDefault()
    }
    
    func configure(data magazine: Magazine) {
        mainImageView.downSampling(url: magazine.imageUrl)
        titleLabel.text = magazine.title
        subtitleLabel.text = magazine.subtitle
        dateLabel.text = magazine.formattedDate
    }
    
    private func configurelDefault() {
        mainImageView.configure(cornerRadius: 12, contentMode: .scaleAspectFill)
        
        titleLabel.configure(font: .boldSystemFont(ofSize: 24), numberOfLines: 0)
        subtitleLabel.configure(color: .gray)
        dateLabel.configure(color: .gray, alignment: .right)
    }
}
