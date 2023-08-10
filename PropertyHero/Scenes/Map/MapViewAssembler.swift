//
//  MapViewAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit
import Reusable
import CoreLocation

protocol MapViewAssembler {
    func resolve(navigationController: UINavigationController, option: OptionChoice, latlng: CLLocationCoordinate2D) -> MapViewViewController
    func resolve(navigationController: UINavigationController, option: OptionChoice, latlng: CLLocationCoordinate2D) -> MapViewViewModel
    func resolve(navigationController: UINavigationController) -> MapViewNavigatorType
    func resolve() -> MapViewUseCaseType
}

extension MapViewAssembler {
    func resolve(navigationController: UINavigationController, option: OptionChoice, latlng: CLLocationCoordinate2D) -> MapViewViewController {
        let vc = MapViewViewController.instantiate()
        let vm: MapViewViewModel = resolve(navigationController: navigationController, option: option, latlng: latlng)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, option: OptionChoice, latlng: CLLocationCoordinate2D) -> MapViewViewModel {
        return MapViewViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            option: option,
            latlng: latlng
        )
    }
}

extension MapViewAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MapViewNavigatorType {
        return MapViewNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> MapViewUseCaseType {
        return MapViewUseCase(productGateway: resolve())
    }
}
