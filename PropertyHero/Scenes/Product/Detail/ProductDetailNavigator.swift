//
//  ProductDetailNavigator.swift
//  Gomi Mall
//
//  Created by KHOI LE on 5/28/21.
//  Copyright © 2021 GomiCorp. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ProductDetailNavigatorType {
    func homeBack()
    func toLogin()
}

struct ProductDetailNavigator: ProductDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func homeBack() {
        navigationController.popToRootViewController(animated: false)
        for viewController in navigationController.viewControllers {
            if viewController is UITabBarController {
                (viewController as! UITabBarController).selectedIndex = 0
                break
            }
        }
    }
    
    func toLogin() {
        let vc: LoginViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
