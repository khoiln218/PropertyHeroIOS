//
//  ProductViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProductViewModel {
    let navigator: ProductNavigatorType
    let useCase: ProductUseCaseType
}

// MARK: - ViewModel
extension ProductViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
