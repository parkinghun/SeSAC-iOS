//
//  ShoppingResultViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation

final class ShoppingResultViewModel {
    var inputQuery: Observable<String?> = Observable(nil)
    var inputIndexPaths: Observable<[IndexPath]> = Observable([])
    var inputSort: Observable<Sort> = Observable(.sim)
    
    private(set) var outputShoppingList: Observable<[Product]> = Observable([])
    private(set) var outputRecommendList: Observable<[Product]> = Observable([])
    private(set) var outputErrorEntity: Observable<ShoppingManager.ShoppingAPIError?> = Observable(nil)
    
    private var start = 1
    private(set) var total = 0
    private(set) var display = 20
    var isEnd: Bool {
        return total <= outputShoppingList.value.count
    }
    
    /*  95
     if scrollIndex == (outputShoppingList.value.count - 5), !isEnd {
     start += display
     fetchProducts(query: query, display: display , sort: sort, type: .search)
     print("새로운 네트워크 요청")
     }
     */
    
    init(query: String?) {
        inputQuery.value = query
        
        inputQuery.bind { [weak self] value in
            guard let self else { return }
            fetchProducts(query: value, display: display, sort: inputSort.value, type: .search)
        }
        inputIndexPaths.lazyBind { [weak self] value in
            guard let self else { return }
            
            self.pagination(query: query, sort: inputSort.value, indexPaths: value)
            
        }
        inputSort.lazyBind { [weak self] value in
            guard let self else { return }
            start = 1
            outputShoppingList.value.removeAll()
            
            fetchProducts(query: inputQuery.value, display: display, sort: value, type: .search)
        }
        
        fetchProducts(query: "맥북", display: display, sort: inputSort.value, type: .remommend)
    }
}

private extension ShoppingResultViewModel {
    enum ListType {
        case search
        case remommend
    }
    
    func fetchProducts(query: String?, display: Int, sort: Sort, type: ListType) {
        guard let query else { return }
        
        ShoppingManager.shared.callRequest(query: query, display: display , start: start, sort: sort) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(result):
                switch type {
                case .search:
                    total = result.total
                    outputShoppingList.value.append(contentsOf: result.items)
                case .remommend:
                    outputRecommendList.value = result.items
                }
            case let .failure(shoppingError):
                outputErrorEntity.value = shoppingError
            }
        }
    }

    func pagination(query: String?, sort: Sort, indexPaths: [IndexPath]) {
        print("indexPaths", indexPaths)
        for item in indexPaths {
            print("item", item)
            
            if !isEnd && item.row == outputShoppingList.value.count - 4 {
                start += display
                fetchProducts(query: query, display: display , sort: sort, type: .search)
                print("새로운 네트워크 요청")
            }
        }
    }
}
