//
//  AccountDeletionNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import UIKit

protocol AccountDeletionNavigatorType {
    
}

struct AccountDeletionNavigator: AccountDeletionNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
