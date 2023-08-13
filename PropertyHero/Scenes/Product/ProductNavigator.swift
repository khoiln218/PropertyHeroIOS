//
//  ProductNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

protocol ProductNavigatorType {
    
}

struct ProductNavigator: ProductNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
