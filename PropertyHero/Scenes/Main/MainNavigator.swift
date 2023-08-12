//
//  MainNavigator.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import UIKit

protocol MainNavigatorType {
    func initMain(_ target: MainViewController)
    func toTabMenu(_ target: MainViewController, tab: TabMenu);
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func initMain(_ target: MainViewController) {
        let vcHome: HomeViewController = assembler.resolve(navigationController: navigationController)
        let vcSearch: SearchViewController = assembler.resolve(navigationController: navigationController)
        let vcCollection: CollectionViewController = assembler.resolve(navigationController: navigationController)
        let vcNotification: NotificationViewController = assembler.resolve(navigationController: navigationController)
        let vcMore: MoreViewController = assembler.resolve(navigationController: navigationController)
        navigationController.addFragmentToMain(target, vc: vcMore, tab: .more)
        navigationController.addFragmentToMain(target, vc: vcNotification, tab: .notification)
        navigationController.addFragmentToMain(target, vc: vcCollection, tab: .collection)
        navigationController.addFragmentToMain(target, vc: vcSearch, tab: .search)
        navigationController.addFragmentToMain(target, vc: vcHome, tab: .home)
    }
    
    func toTabMenu(_ target: MainViewController, tab: TabMenu) {
        navigationController.showViewControllerInMain(target, tab: tab)
    }
}

