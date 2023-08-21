//
//  MoreNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit

protocol MoreNavigatorType {
    func toLogin()
}

struct MoreNavigator: MoreNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toLogin() {
        let vc: LoginViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
