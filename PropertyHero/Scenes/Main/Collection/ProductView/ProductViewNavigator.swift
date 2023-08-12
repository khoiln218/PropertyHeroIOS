//
//  ProductViewNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

protocol ProductViewNavigatorType {
    
}

struct ProductViewNavigator: ProductViewNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
