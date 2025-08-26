//
//  BoxOfficeViewMdoel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: ConfigureViewModelProtocol {
    struct Input {
        let query: ControlProperty<String>
        let searchTapped: ControlEvent<Void>
    }
    struct Output {
        let data: PublishSubject<[DailyBoxOffice]>
        let showToast: Driver<Toast>
    }
    
    var disposeBag = DisposeBag()

    private let apiKey = Bundle.main.apiKey
    lazy var baseURL =
    "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt="

    init() { }
    
    func transform(input: Input) -> Output {
        let data = PublishSubject<[DailyBoxOffice]>()
        let showToast = PublishRelay<Toast>()
        input.searchTapped
            .withLatestFrom(input.query)
            .withUnretained(self)
            .map { self.baseURL + $1 }
            .flatMap { self.fetchData(url: $0)
                    .catch { error in
                        showToast.accept(Toast(status: .warning, message: "알 수 없는 에러"))
                        
                        return PublishSubject.never()
                    }
            }
            .bind(with: self) { owner, value in
                data.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(data: data,
                      showToast: showToast.asDriver(onErrorJustReturn: .init(status: .check, message: ""))
        )
    }
}

private extension BoxOfficeViewModel {
    func fetchData(url: String) -> Observable<[DailyBoxOffice]> {
        
        return Observable<[DailyBoxOffice]>.create { observer in
            
            NetworkManager.shared.callRequest(url: url) { (result: Result<BoxOfficeResult, NetworkError>) in
                
                switch result {
                case .success(let boxOfficeResult):
                    observer.onNext(boxOfficeResult.boxOfficeResult.dailyBoxOfficeList)
                case .failure(_):
                    observer.onError(NetworkError.invalid)
                }
            }
            
            return Disposables.create()
        }
    }
}
