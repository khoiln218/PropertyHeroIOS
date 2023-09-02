//
//  SettingNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 9/2/23.
//

import UIKit

protocol SettingNavigatorType {
    
}

struct SettingNavigator: SettingNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
