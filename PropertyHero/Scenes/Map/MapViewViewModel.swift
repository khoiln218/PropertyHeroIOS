//
//  MapViewViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import MGArchitecture
import RxSwift
import RxCocoa
import CoreLocation

struct MapViewViewModel {
    let navigator: MapViewNavigatorType
    let useCase: MapViewUseCaseType
    let title: String
    let latlng: CLLocationCoordinate2D
    let type: PropertyType
}

// MARK: - ViewModel
extension MapViewViewModel: ViewModel {
    struct Input {
        let cameraChaged: Driver<SearchInfo>
    }
    
    struct Output {
        @Property var extraData: [String: Any]?
        @Property var products: [Product] = []
        @Property var error: Error?
        @Property var isLoading = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output(extraData: ["Title": title, "Latlng": latlng, "Type": type])
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()
        
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
        
        loading
            .drive(output.$isLoading)
            .disposed(by: disposeBag)
        
        error
            .drive(output.$error)
            .disposed(by: disposeBag)
        
        return output
    }
}
