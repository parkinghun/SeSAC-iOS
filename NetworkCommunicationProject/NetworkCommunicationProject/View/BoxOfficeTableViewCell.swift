//
//  BoxOfficeTableViewCell.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/24/25.
//

import UIKit
import SnapKit

final class BoxOfficeTableViewCell: UITableViewCell {
    
    typealias DSFont = DesignSystem.Font
    static let id = "BoxOfficeTableViewCell"
    
    let wrapperView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let rankLabel = {
        let label = UILabel()
        label.configure(text: "1", font: DSFont.title3Bold, bgColor: .white, alignment: .center)
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.configure(text: "주디", font: DSFont.title3, color: .white, alignment: .left)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.configure(text: "20140730", font: DSFont.footnote, color: .white, alignment: .left)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(row data: Movie, rank: Int) {
        rankLabel.text = String(rank)
        titleLabel.text = data.title
        dateLabel.text = data.releaseDate
    }
}

extension BoxOfficeTableViewCell: ViewDesignProtocol {
    func configureHierachy() {
        contentView.addSubview(wrapperView)
        
        wrapperView.addSubview(rankLabel)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        wrapperView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.leading.equalTo(wrapperView)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(12)
            $0.height.equalTo(rankLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(wrapperView)
            $0.centerY.equalTo(titleLabel)
        }
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
    
    
}
