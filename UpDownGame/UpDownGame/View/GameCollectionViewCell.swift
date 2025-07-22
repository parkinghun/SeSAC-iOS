//
//  GameCollectionViewCell.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/22/25.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var labelWrapperView: UIView!
    @IBOutlet var numberLabel: UILabel!

    static let id = String(describing: GameCollectionViewCell.self)
    
    override var isSelected: Bool {
        didSet {
            configureSelectItem(isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelWrapperView.backgroundColor = .white
        numberLabel.textColor = .black
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        labelWrapperView.setCorner(radius: labelWrapperView.frame.width / 2)
    }
    
    func configure(number: Int) {
        numberLabel.text = String(number)
        
    }
    
    private func configureUI() {
        labelWrapperView.backgroundColor = .white
    }
    
    private func configureSelectItem(_ isSelected: Bool) {
        if isSelected {
            labelWrapperView.backgroundColor = .black
            numberLabel.textColor = .white
        } else {
            labelWrapperView.backgroundColor = .white
            numberLabel.textColor = .black
        }
    }
}
