//
//  FilterNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/25/23.
//

import UIKit

protocol FilterNavigatorType {
    
}

struct FilterNavigator: FilterNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
