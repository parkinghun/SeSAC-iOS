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

class LocationViewController: UIViewController {
    
    private let mapView = MKMapView()
    lazy var locationManager = CLLocationManager()
    let weatherLabel = {
        let label = UILabel()
        label.text = "날씨 정보를 불러오는 중..."
        label.numberOfLines = 0
        return label
    }()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureDelegate()
        request()
        bind()
    }
    
    private func bind() {
        let input = LocationViewModel.Input(locationButtonTapped: locationButton.rx.tap, resetButtonTapped: resetButton.rx.tap)
        let output = viewModel.transform(intput: input)
        
        
    }
    
    private func request() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("1. 권한 허용, 사용 가능한 상태")
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization()
                }
            } else {
                print("1. 아이폰의 위치 서비스가 꺼져있어서, 위치 권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    private func checkCurrentLocationAuthorization() {
        
        var status: CLAuthorizationStatus = locationManager.authorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("2. 권한 설정 전")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("2. 시용자 거부 -> iOS 설정 창 이동 알럿")
            let coordinate = MKCoordinateRegion(center: viewModel.sesacCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(coordinate, animated: true)
            addPin(coordinate: viewModel.sesacCoordinate)
        case .authorizedWhenInUse:
            print("2. 사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음")
            locationManager.startUpdatingLocation()
        default: print(status)
        }
        
    }
    
    private func addPin(coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
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
    
    private func configureDelegate() {
        locationManager.delegate = self
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        
        guard let coordinate = locations.first?.coordinate else { return }
        print(locations)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        self.addPin(coordinate: coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        request()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}

