//
//  AppDelegate.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import RxCocoa
import RxSwift
import UIKit
import GoogleMaps

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        GMSServices.provideAPIKey("AIzaSyCweUKlL7MrYKl5qXC1YBL6U4y4DSZZTn4")
        
        bindViewModel(window: window)
    }

    private func bindViewModel(window: UIWindow) {
        let vc: SplashViewController = assembler.resolve(window: window)
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
