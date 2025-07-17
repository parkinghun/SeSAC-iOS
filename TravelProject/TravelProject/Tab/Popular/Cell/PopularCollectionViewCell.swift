//
//  PopularCollectionViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/17/25.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: PopularCollectionViewCell.self)
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDefault()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityImageView.configure(cornerRadius: cityImageView.frame.width / 2, contentMode: .scaleToFill)
    }
    
    func configure(item data: City) {
        cityImageView.downSampling(url: data.cityImageURL)
        nameLabel.configure(text: data.nameLabelText)
        explainLabel.configure(text: data.cityExplain)
    }
    
    func hilightedMatchedText(keyword: String) {
        nameLabel.asFontColor(targetString: keyword, color: .systemPink)
        explainLabel.asFontColor(targetString: keyword, color: .systemPink)
    }
    
    private func configureDefault() {
        nameLabel.configure(font: .boldSystemFont(ofSize: 15), alignment: .center)
        explainLabel.configure(color: .gray, alignment: .center, numberOfLines: 0)
    }

}
