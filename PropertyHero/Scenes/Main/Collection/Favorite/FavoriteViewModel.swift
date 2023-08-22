//
//  FavoriteViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

// MARK: - ViewModel
extension FavoriteViewModel: ViewModel {
    struct Input {
        let trigger: Driver<Void>
        let selected: Driver<IndexPath>
    }
    
    struct Output {
        @Property var products: [Product]?
        @Property var error: Error?
        @Property var isLoading = false
        @Property var isEmpty = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator
            .asDriver()
        
        let products = input.trigger
            .flatMapLatest { _ in
                Driver.just(FavoriteStorage().getFavorites())
            }
        
        products
            .drive(output.$products)
            .disposed(by: disposeBag)
        
        select(trigger: input.selected, items: products)
            .drive(onNext: { product in
                self.navigator.toProductDetail(product.Id)
            })
            .disposed(by: disposeBag)
        
        checkIfDataIsEmpty(trigger: loading, items: products)
            .drive(output.$isEmpty)
            .disposed(by: disposeBag)
        
        loading
            .drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        errorTracker
            .asDriver()
            .drive(output.$error)
            .disposed(by: disposeBag)
        
        return output
    }
}
