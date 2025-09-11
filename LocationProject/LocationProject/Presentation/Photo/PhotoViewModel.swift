//
//  PhotoViewModel.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation
import RxSwift
import RxCocoa
import PhotosUI

final class PhotoViewModel {
    struct Input {
        let addButtonTapped: ControlEvent<Void>
        let selecedImages: Observable<[UIImage]>
    }
    struct Output {
        let presentPhotoView: Driver<Void>
        let images: Driver<[UIImage]>
    }
    
    private let disposeBag = DisposeBag()
    init() { }
    
    func transform(input: Input) -> Output {
        let presentPhotoView = PublishRelay<Void>()
        let images = PublishRelay<[UIImage]>()
        input.addButtonTapped
            .bind(to: presentPhotoView)
            .disposed(by: disposeBag)
        
        input.selecedImages
            .bind(to: images)
            .disposed(by: disposeBag)
        
        return Output(presentPhotoView: presentPhotoView.asDriver(onErrorJustReturn: ()),
                      images: images.asDriver(onErrorJustReturn: []))
    }
}
