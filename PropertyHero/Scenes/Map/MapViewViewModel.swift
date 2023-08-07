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
        
    }
    
    struct Output {
        @Property var option: OptionChoice = .all
        @Property var error: Error?
        @Property var isLoading = false
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output(option: option)
        return output
    }
}
