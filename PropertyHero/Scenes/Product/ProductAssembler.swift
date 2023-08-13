//
//  ProductAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit
import Reusable

protocol ProductAssembler {
    func resolve(navigationController: UINavigationController) -> ProductViewController
    func resolve(navigationController: UINavigationController) -> ProductViewModel
    func resolve(navigationController: UINavigationController) -> ProductNavigatorType
    func resolve() -> ProductUseCaseType
}

extension ProductAssembler {
    func resolve(navigationController: UINavigationController) -> ProductViewController {
        let vc = ProductViewController.instantiate()
        let vm: ProductViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ProductViewModel {
        return ProductViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension ProductAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ProductNavigatorType {
        return ProductNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ProductUseCaseType {
        return ProductUseCase()
    }
}
