//
//  ProductDetailViewModel.swift
//  Gomi Mall
//
//  Created by KHOI LE on 5/28/21.
//  Copyright © 2021 GomiCorp. All rights reserved.
//

import MGArchitecture
import RxCocoa
import RxSwift

struct ProductDetailViewModel {
    let navigator: ProductDetailNavigatorType
    let useCase: ProductDetailUseCaseType
    let productId: Int
}

// MARK: - ViewModel
extension ProductDetailViewModel: ViewModel {
    struct Input {
        let load: Driver<Void>
    }
    
    struct Output {
        @Property var productId: Int
        @Property var detail: [Int: Any]?
        @Property var error: Error?
        @Property var isLoading = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output(productId: productId)
        
        let error = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let product = input.load
            .flatMapLatest{ self.useCase.productDetail(productId, accountId: 0, isMeViewThis: 0)
                    .trackError(error)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let relocations = product
            .flatMapLatest { product in
                self.useCase.getPowerLink(product.ProvinceID)
                    .trackError(error)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
                    .map { relocations in
                        return [0: product, 1: relocations]
                    }
            }
        
        relocations
            .drive(output.$detail)
            .disposed(by: disposeBag)
        
        error
            .asDriver()
            .drive(output.$error)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asDriver()
            .drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        return output
    }
}
