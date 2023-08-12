//
//  SearchByLocationNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/11/23.
//

import UIKit

protocol SearchByLocationNavigatorType {
    
}

struct SearchByLocationNavigator: SearchByLocationNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
