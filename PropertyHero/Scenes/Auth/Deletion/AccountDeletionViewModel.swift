//
//  AccountDeletionViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct AccountDeletionViewModel {
    let navigator: AccountDeletionNavigatorType
    let useCase: AccountDeletionUseCaseType
}

// MARK: - ViewModel
extension AccountDeletionViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
