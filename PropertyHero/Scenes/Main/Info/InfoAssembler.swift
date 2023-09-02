//
//  InfoAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 9/2/23.
//

import UIKit
import Reusable

protocol InfoAssembler {
    func resolve(navigationController: UINavigationController) -> InfoViewController
    func resolve(navigationController: UINavigationController) -> InfoViewModel
    func resolve(navigationController: UINavigationController) -> InfoNavigatorType
    func resolve() -> InfoUseCaseType
}

extension InfoAssembler {
    func resolve(navigationController: UINavigationController) -> InfoViewController {
        let vc = InfoViewController.instantiate()
        let vm: InfoViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> InfoViewModel {
        return InfoViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension InfoAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> InfoNavigatorType {
        return InfoNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> InfoUseCaseType {
        return InfoUseCase()
    }
}
