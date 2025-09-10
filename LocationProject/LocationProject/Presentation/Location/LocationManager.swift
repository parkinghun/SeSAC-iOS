//
//  LocationManager.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

final class LocationManager: NSObject {
    enum LocationPermissonEvent {
        case notDetermined
        case denied
        case authorizedWhenInUse
        case locationServiceDisabled
    }
    
    static let shared = LocationManager()
    
    let updateLocationEvent = PublishRelay<CLLocationCoordinate2D>()
    let statusEvent = PublishRelay<LocationPermissonEvent>()
    lazy var locationManager = CLLocationManager()
    var sesacCordinate = CLLocationCoordinate2D(latitude: 37.517764, longitude: 126.886445)
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        requestLocationAuthentication()
    }
    
    func requestLocationAuthentication() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                print("1. 권한 허용, 사용 가능한 상태")
                DispatchQueue.main.async { // weak self 비교
                    self.checkCurrentLocationAuthorization()
                }
            } else {
                print("1. 아이폰의 위치 서비스가 꺼져있어서, 위치 권한 요청을 할 수 없습니다.")
                statusEvent.accept(.locationServiceDisabled)
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
            //TODO: - 권한 설정에 대한 시스템 알럿
            print("2. 권한 설정 전")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .denied:
            //TODO: - 사용자가 위치 권한을 거부한 경우에는 청년취업사관학교 영등포 캠퍼스가 맵뷰의 중심이 되도록 설정
            print("2. 시용자 거부 -> iOS 설정 창 이동 알럿")
            updateLocationEvent.accept(sesacCordinate)
            statusEvent.accept(.denied)
            // 알럿 띄우기
            
        case .authorizedWhenInUse:
            //TODO: - 사용자 위치를 업데이트 시작
            print("2. 사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음")
            locationManager.startUpdatingLocation()

        default: print(status)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let coordinate = locations.first?.coordinate else { return }
        print(locations)
        updateLocationEvent.accept(coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        requestLocationAuthentication()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}


extension CLLocationCoordinate2D {
    var toCoordinate: Coordinate {
        return Coordinate(lat: latitude, lon: longitude)
    }
}
