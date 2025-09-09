//
//  ViewController.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

class LocationViewController: UIViewController {
    
    private let mapView = MKMapView()
    private lazy var mapHelper = MapViewHepler(mapView: mapView)
    
    let weatherLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    //TODO: - 버튼 컴포넌트 만들기 + 그림자
    let locationButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        // 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        button.layer.shadowOffset = CGSize(width: 0, height: 20)
        /// shadow의 투명도 (0 ~ 1)
        button.layer.shadowOpacity = 0.8
        /// shadow의 corner radius
        button.layer.shadowRadius = 5.0
        
        return button
    }()
    let resetButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()
    
    private let viewModel = LocationViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        bind()
    }
    
    private func bind() {
        // 현재 위치를 알 수 있는 방법
        let input = LocationViewModel.Input(locationButtonTapped: locationButton.rx.tap,
                                            resetButtonTapped: resetButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.weatherData
            .drive(weatherLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.mapCoordinate
            .drive(with: self) { owner, coordinate in
                owner.mapHelper.setRegion(lat: coordinate.lat, lon: coordinate.lon)
            }
            .disposed(by: disposeBag)
        
        output.showAlert
            .emit(with: self) { owner, value in
                owner.showAlert(value)
            }
            .disposed(by: disposeBag)
        
    }

    private func configureHierachy() {
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        view.addSubview(weatherLabel)
        view.addSubview(locationButton)
        view.addSubview(resetButton)
    }
    
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        locationButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.size.equalTo(44)
        }
        resetButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.size.equalTo(44)
        }
    }
}
