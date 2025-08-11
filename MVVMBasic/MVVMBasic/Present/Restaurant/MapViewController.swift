//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    private let mapView = MKMapView()
    private let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        
        viewModel.outputRestaurantList.lazyBind { [weak self] list in
            guard let self else { return }
            createAnnotation(for: list)
        }
    }
}

private extension MapViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard  // 기본지도
        mapView.showsUserLocation = true  // 위치 사용시 사용자 현재 위치 표시
        mapView.userTrackingMode = .none  // 사용자 위치 추적 x
         
        createAnnotation(for: viewModel.list)
    }

    
    /// 레스토랑 정보로 annotation 생성 후 카메라 중앙에 위치
    /// - Parameter filteredList: 레스토랑 배열
    func createAnnotation(for list: [Restaurant]) {
        mapView.removeAnnotations(mapView.annotations)

        var annotations: [MKAnnotation] = []
        list.forEach {
            let annotation = CustomAnnotation(title: $0.name, coordinate: .init(latitude: $0.latitude, longitude: $0.longitude))
            mapView.addAnnotation(annotation)
            annotations.append(annotation)
        }
        
        let center = centerCoordinate(for: annotations)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
     
    func centerCoordinate(for annotations: [MKAnnotation]) -> CLLocationCoordinate2D {
        guard !annotations.isEmpty else { return kCLLocationCoordinate2DInvalid }

        var averageLat: CLLocationDegrees = 0
        var averageLon: CLLocationDegrees = 0

        for annotation in annotations {
            averageLat += annotation.coordinate.latitude
            averageLon += annotation.coordinate.longitude
        }

        averageLat /= CLLocationDegrees(annotations.count)
        averageLon /= CLLocationDegrees(annotations.count)

        return CLLocationCoordinate2D(latitude: averageLat, longitude: averageLon)
    }
    
    @objc func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "전체", style: .default) { [weak self] _ in
            guard let self else { return }
            print("얼럿 1이 선택되었습니다.")
            viewModel.inputActionSheetAction.value = .all
        }
        
        let alert2Action = UIAlertAction(title: "한식", style: .default) { [weak self] _ in
            guard let self else { return }
            print("얼럿 2가 선택되었습니다.")
            viewModel.inputActionSheetAction.value = .korean
        }
        
        let alert3Action = UIAlertAction(title: "양식", style: .default) { [weak self] _ in
            guard let self else { return }
            print("얼럿 3이 선택되었습니다.")
            viewModel.inputActionSheetAction.value = .western
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
