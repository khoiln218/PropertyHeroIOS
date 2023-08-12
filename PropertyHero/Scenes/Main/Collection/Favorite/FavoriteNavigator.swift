//
//  FavoriteNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

protocol FavoriteNavigatorType {
    
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
