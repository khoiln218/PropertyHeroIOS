//
//  MoreNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit

protocol MoreNavigatorType {
    
}

struct MoreNavigator: MoreNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
