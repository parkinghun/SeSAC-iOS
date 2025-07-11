//
//  ShoppingTableViewCell.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/10/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    static let id = "ShoppingTableViewCell"
    
    var checkButtonAction: (() -> Void)?
    var favoriteButtonAction: (() -> Void)?
    
    @IBOutlet var outerView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var todoabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureUI() {
        outerView.backgroundColor = .systemGray4
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
        checkButton.setTitle("", for: .normal)
        checkButton.tintColor = .black
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.tintColor = .black
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        checkButtonAction?()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButtonAction?()
    }
}
