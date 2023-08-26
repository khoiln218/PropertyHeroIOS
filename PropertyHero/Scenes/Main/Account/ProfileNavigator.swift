//
//  ProfileNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import UIKit

protocol ProfileNavigatorType {
    
}

struct ProfileNavigator: ProfileNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
