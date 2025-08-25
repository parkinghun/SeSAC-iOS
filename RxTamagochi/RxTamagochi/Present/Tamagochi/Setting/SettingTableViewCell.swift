//
//  SettingTableViewCell.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import UIKit
import SnapKit
import RxSwift

final class SettingTableViewCell: UITableViewCell, ReuseViewProtocol {
    
    let leftImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(hexCode: "#4D6A78")
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        return label
    }()
    
    let nameLabel = {
        let label = UILabel()
        
        return label
    }()
    
    let rightImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.forward")
        iv.tintColor = UIColor(hexCode: "#4D6A78")
        return iv
    }()
    let separator = UIView()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierachy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func configure(row setting: SettingRow) {
        leftImageView.image = UIImage(systemName: setting.kind.image)
        titleLabel.text = setting.kind.title
        
        switch setting.kind {
        case .name:
            nameLabel.text = ""
        default: break
        }

        nameLabel.text = setting.rightTitle
    }
}

private extension SettingTableViewCell {
    func configureHierachy() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(separator)
    }
    
    func configureLayout() {
        leftImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.size.equalTo(25)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftImageView.snp.trailing).offset(12)
        }
        nameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(rightImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        separator.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func configureView() {
        separator.backgroundColor = .lightGray
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
