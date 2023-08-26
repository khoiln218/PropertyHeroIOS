//
//  FilterViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/25/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct FilterViewModel {
    let navigator: FilterNavigatorType
    let useCase: FilterUseCaseType
}

// MARK: - ViewModel
extension FilterViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
