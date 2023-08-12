//
//  SearchByMarkerAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/11/23.
//

import UIKit
import Reusable

protocol SearchByMarkerAssembler {
    func resolve(navigationController: UINavigationController) -> SearchByMarkerViewController
    func resolve(navigationController: UINavigationController) -> SearchByMarkerViewModel
    func resolve(navigationController: UINavigationController) -> SearchByMarkerNavigatorType
    func resolve() -> SearchByMarkerUseCaseType
}

extension SearchByMarkerAssembler {
    func resolve(navigationController: UINavigationController) -> SearchByMarkerViewController {
        let vc = SearchByMarkerViewController.instantiate()
        let vm: SearchByMarkerViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> SearchByMarkerViewModel {
        return SearchByMarkerViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension SearchByMarkerAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchByMarkerNavigatorType {
        return SearchByMarkerNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> SearchByMarkerUseCaseType {
        return SearchByMarkerUseCase(locationGateway: resolve())
    }
}
