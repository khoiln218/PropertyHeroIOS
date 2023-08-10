//
//  MapViewViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct MapViewViewModel {
    let navigator: MapViewNavigatorType
    let useCase: MapViewUseCaseType
    let option: OptionChoice
}

// MARK: - ViewModel
extension MapViewViewModel: ViewModel {
    struct Input {
        let cameraChaged: Driver<SearchInfo>
    }
    
    struct Output {
        @Property var option: OptionChoice = .all
        @Property var products: [Product] = []
        @Property var error: Error?
        @Property var isLoading = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output(option: option)
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let products = input.cameraChaged
            .flatMapLatest { searchInfo -> Driver<[Product]> in
                return self.useCase.search(searchInfo)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
            }
        
        products
            .drive(output.$products)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asDriver()
            .drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        errorTracker
            .asDriver()
            .drive(output.$error)
            .disposed(by: disposeBag)
        
        return output
    }
}
