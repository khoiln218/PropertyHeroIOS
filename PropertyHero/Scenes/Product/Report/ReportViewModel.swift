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
    let productId: Int
}

// MARK: - ViewModel
extension ReportViewModel: ViewModel {
    struct Input {
        let warningType: Driver<Int>
        let content: Driver<String>
        let report: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.report
            .withLatestFrom(Driver.combineLatest(
            input.warningType,
            input.content
        ))
            .flatMapLatest {
                self.useCase.sendReport(productId, accountId: AccountStorage().getAccount().Id, type: $0.0, content: $0.1)
                    .asDriverOnErrorJustComplete()
            }
            .drive()
            .disposed(by: disposeBag)
        
        return output
    }
}
