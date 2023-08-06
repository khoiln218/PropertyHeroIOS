//
//  MoreViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct MoreViewModel {
    let navigator: MoreNavigatorType
    let useCase: MoreUseCaseType
}

// MARK: - ViewModel
extension MoreViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
