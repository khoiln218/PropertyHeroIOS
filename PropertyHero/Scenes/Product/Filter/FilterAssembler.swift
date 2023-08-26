//
//  FilterAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/25/23.
//

import UIKit
import Reusable

protocol FilterAssembler {
    func resolve(navigationController: UINavigationController) -> FilterViewController
    func resolve(navigationController: UINavigationController) -> FilterViewModel
    func resolve(navigationController: UINavigationController) -> FilterNavigatorType
    func resolve() -> FilterUseCaseType
}

extension FilterAssembler {
    func resolve(navigationController: UINavigationController) -> FilterViewController {
        let vc = FilterViewController.instantiate()
        let vm: FilterViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> FilterViewModel {
        return FilterViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension FilterAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FilterNavigatorType {
        return FilterNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> FilterUseCaseType {
        return FilterUseCase()
    }
}
