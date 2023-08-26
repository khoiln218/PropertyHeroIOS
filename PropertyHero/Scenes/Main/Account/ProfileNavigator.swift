//
//  ProfileNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import UIKit

protocol ProfileNavigatorType {
    func backHome()
    func toAccountDeletion()
}

struct ProfileNavigator: ProfileNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func backHome() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func toAccountDeletion() {
        let vc: AccountDeletionViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
