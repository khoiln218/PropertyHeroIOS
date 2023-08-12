//
//  SearchByMarkerViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/11/23.
//

import MGArchitecture
import RxSwift
import RxCocoa
import CoreLocation

struct SearchByMarkerViewModel {
    let navigator: SearchByMarkerNavigatorType
    let useCase: SearchByMarkerUseCaseType
}

// MARK: - ViewModel
extension SearchByMarkerViewModel: ViewModel {
    struct Input {
        let trigger: Driver<Void>
        let province: Driver<Province>
        let keyword: Driver<String>
        let selectMarker: Driver<IndexPath>
    }
    
    struct Output {
        @Property var proinces: [Province]?
        @Property var markers: [Marker]?
        @Property var error: Error?
        @Property var isLoading = false
        @Property var isEmpty = true
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator
            .asDriver()
        
        let provinceList = input.trigger
            .flatMapLatest { _ in
                self.useCase.getProvinces()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let loadMarkers = Driver.combineLatest(
            input.keyword.distinctUntilChanged(),
            input.province.distinctUntilChanged { $0.Id }
        )
        
        let markerList = loadMarkers
            .flatMapLatest { keyword, province in
                self.useCase.searchMarkers(keyword, provinceID: province.Id, markerType: Constants.undefined.rawValue)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        provinceList
            .drive(output.$proinces)
            .disposed(by: disposeBag)
        
        markerList
            .drive(output.$markers)
            .disposed(by: disposeBag)
        
        select(trigger: input.selectMarker, items: markerList)
            .drive(onNext: { marker in
                self.navigator.toMapView(marker.Name, latlng: CLLocationCoordinate2D(latitude: marker.Latitude, longitude: marker.Longitude), type: .all)
            })
            .disposed(by: disposeBag)
        
        checkIfDataIsEmpty(trigger: loading, items: markerList)
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
