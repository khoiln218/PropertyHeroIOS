//
//  HomeNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit
import GoogleMaps

protocol HomeNavigatorType {
    func toMapView(_ option: OptionChoice, latlng: CLLocationCoordinate2D)
    
}

struct HomeNavigator: HomeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMapView(_ option: OptionChoice, latlng: CLLocationCoordinate2D) {
        let vc: MapViewViewController = assembler.resolve(navigationController: navigationController, option: option, latlng: latlng)
        navigationController.pushViewController(vc, animated: true)
    }
}
