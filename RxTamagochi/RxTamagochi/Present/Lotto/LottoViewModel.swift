//
//  LottoViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class LottoViewModel: ConfigureViewModelProtocol {
    struct Input {
        let query: ControlProperty<String>
        let checkButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let result: PublishSubject<String>
        let showToast: PublishRelay<Toast>
        let showAlert: PublishRelay<AlertStyle>
    }
    
    typealias LottoResult = Result<LottoData, NetworkError>
    private let baseUrl  = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    
    var disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let resultSubject = PublishSubject<String>()
        let showToast = PublishRelay<Toast>()
        let showAlert = PublishRelay<AlertStyle>()
        
        input.checkButtonTapped
            .withLatestFrom(input.query)
            .withUnretained(self)
            .map { self.baseUrl + $0.1 }
            .flatMap { return self.fetchData(url: $0) }
            .bind(with: self) { owner, response in
                
                switch response {
                case .success(let data):
                    resultSubject.onNext(data.result)
                case .failure(let error):
                    switch error {
                    case .unrechable:
                        showAlert.accept(AlertStyle(title: "네트워크 연결 에러", message: error.message, ok: "확인"))
                    default:
                        showToast.accept(Toast(status: .warning, message: error.message))
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(result: resultSubject, showToast: showToast, showAlert: showAlert)
    }
}

private extension LottoViewModel {
    func fetchData(url: String) -> Single<LottoResult> {
        return Single.create { observer in
            NetworkManager.shared.callRequest(url: url) { (result: Result<Lotto, NetworkError>) in
                
                switch result {
                case .success(let value):
                    let lottoData = LottoData(lotto: value)
                    observer(.success(.success(lottoData)))
                case .failure(let error):
                    observer(.success(.failure(error)))
                }
                
            }
            return Disposables.create()
        }
    }
}



