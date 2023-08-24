//
//  ReportViewModel.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/24/23.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ReportViewModel {
    let navigator: ReportNavigatorType
    let useCase: ReportUseCaseType
}

// MARK: - ViewModel
extension ReportViewModel: ViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
