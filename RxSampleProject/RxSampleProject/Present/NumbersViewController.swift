//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NumbersViewController: UIViewController {
    
    private lazy var number1 = RoundTextField(text: "1", alignment: .right)
    private lazy var number2 = RoundTextField(text: "2", alignment: .right)
    private lazy var number3 = RoundTextField(text: "3", alignment: .right)
    private let plusLabel = {
        let label = UILabel()
        label.text = "+"
        return label
    }()
    private let separator = UIView()
    private let result = {
        let label = UILabel()
        label.text = "-1"
        label.textAlignment = .right
        return label
    }()
    
    private let viewModel = NumbersViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        configureView()
        bind()
    }
    
    private func bind() {
        let input = NumbersViewModel.Input(
            number1: number1.rx.text.orEmpty,
            number2: number2.rx.text.orEmpty,
            number3: number3.rx.text.orEmpty)
        
        let output = viewModel.transorm(input: input)
        
        output.addText
            .asDriver()
            .drive(result.rx.text)
            .disposed(by: disposeBag)
    }
}

private extension NumbersViewController {
    
    func configureHierachy() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(plusLabel)
        view.addSubview(separator)
        view.addSubview(result)
    }
    
    func configureLayout() {
        number1.snp.makeConstraints { make in
            make.trailing.equalTo(number2)
            make.size.equalTo(CGSize(width: 97, height: 30))
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(8)
            make.trailing.equalTo(number3)
            make.size.equalTo(CGSize(width: 97, height: 30))
            
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(8)
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 97, height: 30))
            make.trailing.equalTo(separator)
        }
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(number3.snp.leading).offset(-8)
            make.centerY.equalTo(number3)
        }
        separator.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(8)
            make.width.equalTo(116)
            make.height.equalTo(1)
        }
        result.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(separator)
        }
    }
    
    func configureView() {
        separator.backgroundColor = .lightGray
    }
}
