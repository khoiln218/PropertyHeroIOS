//
//  LoginNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import UIKit

protocol LoginNavigatorType {
    func goBack()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func goBack() {
        navigationController.popViewController(animated: false)
    }
}
