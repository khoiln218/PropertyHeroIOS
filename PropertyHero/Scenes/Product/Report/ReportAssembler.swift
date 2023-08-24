//
//  ReportAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/24/23.
//

import UIKit
import Reusable

protocol ReportAssembler {
    func resolve(navigationController: UINavigationController) -> ReportViewController
    func resolve(navigationController: UINavigationController) -> ReportViewModel
    func resolve(navigationController: UINavigationController) -> ReportNavigatorType
    func resolve() -> ReportUseCaseType
}

extension ReportAssembler {
    func resolve(navigationController: UINavigationController) -> ReportViewController {
        let vc = ReportViewController.instantiate()
        let vm: ReportViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ReportViewModel {
        return ReportViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension ReportAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ReportNavigatorType {
        return ReportNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ReportUseCaseType {
        return ReportUseCase()
    }
}
