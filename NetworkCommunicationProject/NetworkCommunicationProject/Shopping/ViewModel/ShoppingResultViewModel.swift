//
//  ShoppingResultViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation
import Alamofire

final class ShoppingResultViewModel {
    struct Input {
        var query: Observable<String?> = Observable(nil)
        var indexPaths: Observable<[IndexPath]> = Observable([])
        var sort: Observable<Sort> = Observable(.sim)
    }
    
    struct Output {
        private(set) var shoppingList: Observable<[Product]> = Observable([])
        private(set) var recommendList: Observable<[Product]> = Observable([])
        private(set) var errorEntity: Observable<ShoppingManager.ShoppingAPIError?> = Observable(nil)
    }
    
    var input: Input
    var output: Output

    private var start = 1
    private(set) var total = 0
    private(set) var display = 20
    var isEnd: Bool {
        return total <= output.shoppingList.value.count
    }
    
    init(query: String?) {
        input = Input()
        output = Output()
        
        input.query.value = query
        
        input.query.bind { [weak self] value in
            guard let self else { return }
            fetchProducts(query: value, display: display, sort: input.sort.value, type: .search)
        }
        input.indexPaths.lazyBind { [weak self] value in
            guard let self else { return }
            
            self.pagination(query: query, sort: input.sort.value, indexPaths: value)
            
        }
        input.sort.lazyBind { [weak self] value in
            guard let self else { return }
            start = 1
            output.shoppingList.value.removeAll()
            
            fetchProducts(query: input.query.value, display: display, sort: value, type: .search)
        }
        
        fetchProducts(query: "맥북", display: display, sort: input.sort.value, type: .remommend)
    }
}

private extension ShoppingResultViewModel {
    enum ListType {
        case search
        case remommend
    }
    
    func fetchProducts(query: String?, display: Int, sort: Sort, type: ListType) {
        guard let query else { return }
        
        ShoppingManager.shared.callRequest(api: .search(parameters: .init(query: query, display: display, start: start, sort: sort)), type: SearchResult.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(result):
                switch type {
                case .search:
                    total = result.total
                    output.shoppingList.value.append(contentsOf: result.items)
                case .remommend:
                    output.recommendList.value = result.items
                }
            case let .failure(shoppingError):
                output.errorEntity.value = shoppingError
            }
        }
    }
    
    func pagination(query: String?, sort: Sort, indexPaths: [IndexPath]) {
        print("indexPaths", indexPaths)
        for item in indexPaths {
            print("item", item)
            
            // prefetch cancel
            // prefetch는 이미지가 엄청 뜸 이미지 용량이 크면 안볼 이미지는 cancel prefetch를 써야함
            // 페이지네이션보다 빠르게 스크롤할 때 다운 필요 없을 떄 취소시키는 것
            if !isEnd && item.row == output.shoppingList.value.count - 4 {
                start += display
                fetchProducts(query: query, display: display , sort: sort, type: .search)
                print("새로운 네트워크 요청")
            }
        }
    }
}
