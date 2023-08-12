//
//  SearchByLocationViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/11/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct SearchByLocationViewModel {
    let navigator: SearchByLocationNavigatorType
    let useCase: SearchByLocationUseCaseType
}

// MARK: - ViewModel
extension SearchByLocationViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
