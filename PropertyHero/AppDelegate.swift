//
//  AppDelegate.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import RxCocoa
import RxSwift
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        bindViewModel(window: window)
    }

    private func bindViewModel(window: UIWindow) {
        let nav = UINavigationController()
        let vc: SplashViewController = assembler.resolve(window: window)
        nav.viewControllers.append(vc)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
