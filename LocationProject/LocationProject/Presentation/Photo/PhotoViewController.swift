//
//  PhotoViewController.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa
import SnapKit

final class PhotoViewController: UIViewController {
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        return collectionView
    }()
    private let addButtonItem = UIBarButtonItem(systemItem: .add)
    let didFinishPicking = PublishRelay<[UIImage]>()
    
    private var selections = [String: PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    
    private lazy var pickerViewController = {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = PHPickerFilter.any(of: [.images])
        config.selectionLimit = 3
        config.selection = .ordered  // 선택한 순서대로 숫자로 표현
        config.preferredAssetRepresentationMode = .current
        config.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }()
    
    private let dispsoeBag = DisposeBag()
    private let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        setNavigation()
        bind()
    }
    
    private func bind() {
        let input = PhotoViewModel.Input(addButtonTapped: addButtonItem.rx.tap,
                                         selecedImages: didFinishPicking.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.presentPhotoView
            .drive(with: self) { owner, _ in
                owner.present(owner.pickerViewController, animated: true)
            }
            .disposed(by: dispsoeBag)
        
        output.images
            .drive(collectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier, cellType: PhotoCollectionViewCell.self)) { item, element, cell in
                cell.configure(image: element)
            }
            .disposed(by: dispsoeBag)
        
        // TODO: - add 버튼 누르면 PHPickerVC 뜨고 (config - SelectionLimit 3장 이상 선택할 수 있도록)
        // TODO: - 선택한 사진은 수직 스크롤 되도록
        // TODO: - 셀 선택하면 weatherVC에 선택된 사진 보여주기
    }
    
    private func setNavigation() {
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierachy() {
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

// 극단적으로 notification Center로 보내도 괜찮음
extension PhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let queue = DispatchQueue(label: "image.sync")  // 커스텀 -> serial
        var images: [UIImage] = []

        var newSelections = [String: PHPickerResult]()  // picker 작업이 끝난 후 새로 만들어진 selection을 담을 변수 생성
        
        for result in results {
            let identifier = result.assetIdentifier!
            newSelections[identifier] = selections[identifier] ?? result
        }
        
        selections = newSelections
        selectedAssetIdentifiers = results.compactMap { $0.assetIdentifier }
        
        for (_, result) in selections {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let self = self,
                          let image = image as? UIImage else { return }
                    
                    queue.async { images.append(image) }
                }
            }
        }
        
//        let group = DispatchGroup()
//        let queue = DispatchQueue(label: "image.sync")  // 커스텀 -> serial
//        var images: [UIImage] = []
//        
//            results.forEach { result in
//                group.enter()
//
//                let itemProvider = result.itemProvider
//                
//                // itemProvider가 지정된 클래스의 객체를 로드할 수 있는지 여부를 나타내는 부울 값을 반환
//                if itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in   // 비동기 작업
//                        if let image = image as? UIImage {
//                            queue.sync { images.append(image) }
//                        }
//                        group.leave()
//                    }
//                } else {
//                    group.leave()
//                }
//            }
//        
//        
//        group.notify(queue: .main) {
//            self.didFinishPicking.accept(images)
//
//        }
    }
}

// PHPickerViewController 전용 Rx 확장
//extension Reactive where Base: PHPickerViewController {
//    var didFinishPicking: Observable<[UIImage]> {
//        let proxy = PHPickerViewControllerDelegateProxy.proxy(for: base)
//        return proxy.didFinishPickingSubject.asObservable()
//    }
//}
//
//// NotificationCenter 를 통해 Rx
///*
//제네릭 매개변수 - DelegateProxy<PHPickerViewController, PHPickerViewControllerDelegate>,
//ParentObject - DelegateProxyType
//DelegateProtocol - PHPickerViewControllerDelegate
//*/
//final class PHPickerViewControllerDelegateProxy: DelegateProxy<PHPickerViewController, PHPickerViewControllerDelegate>, DelegateProxyType, PHPickerViewControllerDelegate {
//
//    let didFinishPickingSubject = PublishSubject<[UIImage]>()
//    // 런타임에 이 ParentObject(=PHPickerViewController)에는 이 Proxy를 써라 라고 등록
//    // 프레임워크가 proxy(for:) 호출 시 어떤 Proxy를 만들지 알게 해주는 필수 정적 메서드.
//    static func registerKnownImplementations() {
//        self.register { (phpickerViewController) -> PHPickerViewControllerDelegateProxy in
//            PHPickerViewControllerDelegateProxy(parentObject: phpickerViewController, delegateProxy: self)
//        }
//    }
//
//    // 현재 ParentObject에 설정되어 있는 실제 delegate를 반환
//    // Proxy가 생성/연결될 때, 기존 delegate를 알아두고 이벤트 포워딩(필요 시) 등에 사용된다.
//    static func currentDelegate(for object: PHPickerViewController) -> (any PHPickerViewControllerDelegate)? {
//        return object.delegate
//    }
//
//    // ParentObject의 delegate를 바꾼다.
//    // Proxy를 ParentObject에 장착하는 단계에서 호출되어 “이제부터 delegate는 Proxy야” 라고 설정하는 역할.
//    static func setCurrentDelegate(_ delegate: (any PHPickerViewControllerDelegate)?, to object: PHPickerViewController) {
//        return object.delegate = delegate
//    }
//
//    // 원래 델리게이트 콜백
//    // 여기서 결과를 가공(예: UIImage 로드)해서 Subject에 onNext
//    // 이 순간 picker.rx.didFinishPicking을 구독 중인 모든 곳으로 이벤트가 흘러간다.
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        didFinishPickingSubject.onNext(images)
//    }
//}

// 쓰고 안쓰고 차이?
// HasDelegate
