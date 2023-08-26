//
//  ProfileViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProfileViewModel {
    let navigator: ProfileNavigatorType
    let useCase: ProfileUseCaseType
    let account: Account
}

// MARK: - ViewModel
extension ProfileViewModel: ViewModel {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        @Property var account: Account?
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output(account: account)
        
        return output
    }
}
