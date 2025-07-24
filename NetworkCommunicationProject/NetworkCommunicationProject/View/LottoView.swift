//
//  LottoView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit
import SnapKit

protocol LottoViewDelegate: AnyObject {
    func tappedView()
}

final class LottoView: UIView {
    typealias DS = DesignSystem
    private weak var delegate: LottoViewDelegate?
    
    // MARK: - UIComponents
    let roundPickerView = UIPickerView()
    
    let searchTextField = {
        let tf = UITextField()
        tf.font = DS.Font.headline
        tf.textAlignment = .center
        tf.placeholder = "회차를 입력해주세요"
        tf.borderStyle = .roundedRect
        tf.tintColor = .clear
        return tf
    }()
    
    let announceLabel = {
        let label = UILabel()
        label.configure(text: "당첨번호 안내", font: DS.Font.callout)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.configure(text: "2020-05-30 추정", font: DS.Font.footnote, color: .gray)
        return label
    }()
    
    let divider = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let resultLabel = {
        let label = UILabel()
        label.configure(text: "당첨결과", font: DS.Font.title1)
        return label
    }()
    
    let numberLabels: [UILabel] = {
        var labels: [UILabel] = []
        for _ in 0...6 {
            labels.append(UILabel())
        }
        
        labels.forEach {
            $0.configure(font: DS.Font.title3Bold, color: .white, alignment: .center)
        }
        return labels
    }()
    
    let plusLabel = {
        let label = UILabel()
        label.configure(text: "+", alignment: .center)
        return label
    }()
    
    let bonusLabel = {
        let label = UILabel()
        label.configure(text: "보너스", font: DS.Font.subhead)
        return label
    }()
    
    let numberStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    let resultWrapperView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierachy()
        configureLayout()
        configureView()
        setupTapGesture()
    }
    
    override func layoutSubviews() {
        super.layoutIfNeeded()
        numberLabels.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDelegation(_ delegate: LottoViewDelegate) {
        self.delegate = delegate
    }
    
    func configure(row lottoBalls: [LottoBall], round: Int, date: String) {
        
        searchTextField.text = String(round)
        dateLabel.text = date.toFormattedDate()
        
        resultLabel.text = "\(round)회 당첨결과"
        resultLabel.asColor(targetString: "\(round)회", color: .orange)
        
        for (index, ball) in lottoBalls.enumerated() {
            numberLabels[index].text = "\(ball.number)"
            numberLabels[index].backgroundColor = ball.color
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture() {
        delegate?.tappedView()
    }
}

// MARK: Configure UI
extension LottoView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(searchTextField)
        self.addSubview(resultWrapperView)
        
        resultWrapperView.addSubview(announceLabel)
        resultWrapperView.addSubview(dateLabel)
        resultWrapperView.addSubview(divider)
        resultWrapperView.addSubview(resultLabel)
        resultWrapperView.addSubview(numberStackView)
        resultWrapperView.addSubview(bonusLabel)
        
        numberLabels.forEach {
            numberStackView.addArrangedSubview($0)
        }
        
        if numberLabels.count > 1 {
            let boforeLastIndex = numberLabels.count - 1
            numberStackView.insertArrangedSubview(plusLabel, at: boforeLastIndex)
        }
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(30)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(44)
        }
        
        resultWrapperView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(16)
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.height.equalTo(200)
        }
        
        announceLabel.snp.makeConstraints {
            $0.leading.top.equalTo(resultWrapperView).inset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(resultWrapperView).inset(8)
        }
        
        divider.snp.makeConstraints {
            $0.horizontalEdges.equalTo(resultWrapperView).inset(8)
            $0.top.equalTo(announceLabel.snp.bottom).offset(8)
            $0.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.centerX.equalTo(resultWrapperView)
        }
        
        numberStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(resultWrapperView).inset(16)
            $0.bottom.equalTo(bonusLabel.snp.top).offset(-8)
        }
        
        bonusLabel.snp.makeConstraints {
            $0.trailing.equalTo(numberStackView)
            $0.bottom.equalTo(resultWrapperView).offset(-12)
        }
        
        numberLabels.forEach { label in
            label.snp.makeConstraints {
                $0.height.equalTo(label.snp.width).multipliedBy(1)
            }
        }
    }
    
    func configureView() {
        self.backgroundColor = .white
        searchTextField.inputView = roundPickerView
        
    }
}
