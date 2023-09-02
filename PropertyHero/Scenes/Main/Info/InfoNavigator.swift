//
//  InfoNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 9/2/23.
//

import UIKit

protocol InfoNavigatorType {
    
}

struct InfoNavigator: InfoNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
