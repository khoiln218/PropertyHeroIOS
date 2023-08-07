//
//  HomeNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit
import GoogleMaps

protocol HomeNavigatorType {
    func toMapView(option: OptionChoice)
    
}

struct HomeNavigator: HomeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMapView(option: OptionChoice) {
        let vc: MapViewViewController = assembler.resolve(navigationController: navigationController, option: option)
        navigationController.pushViewController(vc, animated: true)
    }
}
