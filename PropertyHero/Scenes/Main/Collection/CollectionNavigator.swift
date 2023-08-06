//
//  CollectionNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit

protocol CollectionNavigatorType {
    
}

struct CollectionNavigator: CollectionNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
