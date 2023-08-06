//
//  MainNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import UIKit

protocol MainNavigatorType {
    func initMain()
    func toMenu(_ index: Int);
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func initMain() {
        let vcHome: HomeViewController = assembler.resolve(navigationController: navigationController)
        let vcSearch: SearchViewController = assembler.resolve(navigationController: navigationController)
        let vcCollection: CollectionViewController = assembler.resolve(navigationController: navigationController)
        let vcNotification: NotificationViewController = assembler.resolve(navigationController: navigationController)
        let vcMore: MoreViewController = assembler.resolve(navigationController: navigationController)
        navigationController.addFragment(vcHome, position: Navigation.home.rawValue)
        navigationController.addFragment(vcSearch, position: Navigation.search.rawValue)
        navigationController.addFragment(vcCollection, position: Navigation.collection.rawValue)
        navigationController.addFragment(vcNotification, position: Navigation.notification.rawValue)
        navigationController.addFragment(vcMore, position: Navigation.more.rawValue)
        
        toMenu(Navigation.home.rawValue)
    }
    
    
    func toMenu(_ index: Int) {
        navigationController.showViewController(index)
    }
}

