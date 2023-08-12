//
//  HomeViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

// MARK: - ViewModel
extension HomeViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        @Property var sections:[Int: Any]?
        @Property var error: Error?
        @Property var isLoading = false
        @Property var isEmpty = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let bannerList = self.useCase.getBanner()
            .trackError(errorTracker)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
        
        let sectionsLoad = bannerList
            .flatMapLatest { banners -> Driver<[Int: Any]> in
                var sections = [Int: Any]()
                sections[0] = PageSectionViewModel(
                    index: 0,
                    type: .banner,
                    title: "Banner",
                    items: banners
                )
                
                return Driver.just(sections)
            }
        
        sectionsLoad
            .drive(output.$sections)
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
