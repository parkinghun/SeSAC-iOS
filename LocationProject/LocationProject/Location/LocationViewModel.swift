//
//  LocationViewModel.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class LocationViewModel {
    struct Input {
        let locationButtonTapped: ControlEvent<Void>
        let resetButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let weatherData: Driver<String>
        let mapCoordinate: Driver<Coordinate>
        let showAlert: Signal<AlertModel>
    }
    
    private let disposeBag = DisposeBag()
    private let date: String = DateFormatter.basic.string(from: .now)
    private let networkManager = NetworkManager.shared
    private let locatoinManager = LocationManager.shared
    
    init () { }
    
    func transform(input: Input) -> Output {
        let weatherData = BehaviorRelay(value: "날씨 정보를 불러오는 중...")
        let showAlert = PublishRelay<AlertModel>()
        let mapCoordinate = PublishRelay<Coordinate>()
        
        //TODO: - 지도 위치
        input.locationButtonTapped
            .withLatestFrom(locatoinManager.updateLocationEvent)
            .map { $0.toCoordinate }
            .bind(to: mapCoordinate)
            .disposed(by: disposeBag)
        
        input.resetButtonTapped
            .withLatestFrom(locatoinManager.updateLocationEvent)
            .map { $0.toCoordinate }
            .withUnretained(self)
            .flatMapLatest{ owner, coordinate in
                mapCoordinate.accept(coordinate)
                return owner.fetchWeatherData(lat: coordinate.lat, lon: coordinate.lon)
            }
            .bind(with: self) { owner, result in
                switch result {
                case let .success(weather):
                    weatherData.accept("""
                        \(owner.date)
                        현재온도: \(weather.temp)
                        풍속: \(weather.windSpped)
                        습도: \(weather.humidity)
                        """)
                case let .failure(error):
                    showAlert.accept(AlertModel(title: "네트워크 에러 발생", message: error.message, preferredStyle: .alert, type: .ok))
                }
            }
            .disposed(by: disposeBag)
        
        locatoinManager.statusEvent
            .bind(with: self) { owner, event in
                switch event {
                case .denied:
                    mapCoordinate.accept(owner.locatoinManager.sesacCordinate.toCoordinate)
                    showAlert.accept(AlertModel(title: "위치 권한 거절", message: "위치 권한을 허용해주세요", preferredStyle: .alert, type: .ok))
                    
                case .locationServiceDisabled:
                    showAlert.accept(AlertModel(title: "위시 서비스 비활성화", message: "기기의 위치 서비스가 꺼져있습니다. 위치 서비스를 활성화해주세요.", preferredStyle: .alert, type: .ok))
                default: print(event)
                }
            }
            .disposed(by: disposeBag)
        
        locatoinManager.updateLocationEvent
            .bind(with: self) { owner, coordinate in
                mapCoordinate.accept(coordinate.toCoordinate)
            }
            .disposed(by: disposeBag)
        
        
        return Output(weatherData: weatherData.asDriver(onErrorJustReturn: ""),
                      mapCoordinate: mapCoordinate.asDriver(onErrorDriveWith: .empty()),
                      showAlert: showAlert.asSignal())
    }
}

private extension LocationViewModel {
    func fetchWeatherData(lat: Double, lon: Double) -> Observable<Result<Weather, NetworkError>> {
        return Observable<Result<Weather, NetworkError>>.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            
            let router = NetworkRouter.weather(lat: lat, lon: lon)
            networkManager.request(api: router, type: WeatherResultDTO.self) { result in
                switch result {
                case let .success(dto):
                    observer.onNext(.success(dto.toModel))
                case let .failure(error):
                    observer.onNext(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}

struct Coordinate {
    let lat: Double
    let lon: Double
}

