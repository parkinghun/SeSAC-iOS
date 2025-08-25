//
//  SelecteDetailView.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SelecteDetailViewController: UIViewController, ConfigureViewControllerProtocol {
    
    let contentView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "#DCF6FC")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let tamagochiView = TamagochiView()
    
    let separator = UIView()
    
    let descriptionLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let divider = UIView()
    
    lazy var vStackView = {
        let sv = UIStackView(arrangedSubviews: [tamagochiView, separator, descriptionLabel])
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    let cancelButton = {
        let bt = UIButton()
        bt.setTitle("취소", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    let startButton = {
        let bt = UIButton()
        bt.setTitle("시작하기", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    lazy var btStackView = {
        let sv = UIStackView(arrangedSubviews: [cancelButton, startButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    let tap = UITapGestureRecognizer()
    
    let viewModel: SelecteDetailViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: SelecteDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        configureView()
        bind()
    }
    
    func bind() {
        let input = SelecteDetailViewModel.Input(
            cancelButtonTapped: cancelButton.rx.tap,
            startButtonTapped: startButton.rx.tap,
            tapEvent: tap.rx.event)
        
        let output = viewModel.transform(input: input)
        output.toast
            .asDriver(onErrorJustReturn: .init(status: .check, message: ""))
            .drive(with: self) { owner, toast in
                owner.navigationController?.showToastMessage(toast)
            }
            .disposed(by: disposeBag)
     
        output.navigationTitle
            .asDriver(onErrorJustReturn: "")
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    func configure(item: TamagochiType) {
        tamagochiView.configure(item: item)
        descriptionLabel.text = item.description
    }
    
    func configureHierachy() {
        view.addSubview(contentView)
        view.addSubview(divider)
        contentView.addSubview(vStackView)
        contentView.addSubview(btStackView)
    }
    
    func configureLayout() {
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(500)
        }
        
        vStackView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.center.equalToSuperview()
        }
        
        tamagochiView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        btStackView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(btStackView.snp.top)
            make.horizontalEdges.equalTo(btStackView)
        }
    }
    
    func configureView() {
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        separator.backgroundColor = .blue
        divider.backgroundColor = .lightGray
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
}
