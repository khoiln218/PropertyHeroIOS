//
//  ProductListNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

protocol ProductListNavigatorType {
    
}

struct ProductListNavigator: ProductListNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
