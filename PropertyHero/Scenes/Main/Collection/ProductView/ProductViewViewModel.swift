//
//  ProductViewViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProductViewViewModel {
    let navigator: ProductViewNavigatorType
    let useCase: ProductViewUseCaseType
}

// MARK: - ViewModel
extension ProductViewViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
