//
//  FavoriteViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

// MARK: - ViewModel
extension FavoriteViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
