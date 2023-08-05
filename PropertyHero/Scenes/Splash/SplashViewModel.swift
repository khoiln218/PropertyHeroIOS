//
//  MainViewModel.swift
//  BaoDongThap
//
//  Created by KHOI LE on 9/20/22.
//

import RxSwift
import RxCocoa
import MGArchitecture

struct SplashViewModel {
    let navigator: SplashNavigatorType
    let useCase: SplashUseCaseType
}

// MARK: - ViewModel
extension SplashViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {

    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        after(interval: 1.0) {
            navigator.toMain()
        }

        return output
    }
}
