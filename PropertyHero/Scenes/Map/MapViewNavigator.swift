//
//  MapViewNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit

protocol MapViewNavigatorType {
    func toProductList(_ searchInfo: SearchInfo, title: String)
}

struct MapViewNavigator: MapViewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toProductList(_ searchInfo: SearchInfo, title: String) {
        let vc: ProductListViewController = assembler.resolve(navigationController: navigationController, searchInfo: searchInfo, title: title)
        navigationController.pushViewController(vc, animated: true)
    }
}
