//
//  LoginNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import UIKit

protocol LoginNavigatorType {
    func goBack()
    func toRegister()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func goBack() {
        navigationController.popViewController(animated: false)
    }
    
    func toRegister() {
        goBack()
        let vc: RegisterViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
