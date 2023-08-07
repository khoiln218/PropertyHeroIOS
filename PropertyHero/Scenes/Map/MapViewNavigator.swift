//
//  MapViewNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit

protocol MapViewNavigatorType {
    
}

struct MapViewNavigator: MapViewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
