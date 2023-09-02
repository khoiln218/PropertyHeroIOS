//
//  InfoViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 9/2/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct InfoViewModel {
    let navigator: InfoNavigatorType
    let useCase: InfoUseCaseType
}

// MARK: - ViewModel
extension InfoViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
