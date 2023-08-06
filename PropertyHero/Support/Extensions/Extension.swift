//
//  Extension.swift
//  BaoDongThap
//
//  Created by KHOI LE on 10/12/22.
//

import UIKit

extension UIView {
    func recursiveFindSubview(of name: String) -> UIView? {
        for view in subviews {
            if view.isKind(of: NSClassFromString(name)!) {
                return view
            }
        }
        for view in subviews {
            if let tempView = view.recursiveFindSubview(of: name) {
                return tempView
            }
        }
        return nil
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension UINavigationController {
    func showViewController(_ index: Int) {
        var mainViewController: MainViewController!
        for viewController in viewControllers {
            if viewController is MainViewController {
                mainViewController = viewController as? MainViewController
                break
            }
        }
        
        if mainViewController == nil { return }
        
        for subview in mainViewController.viewpager.subviews {
            subview.layer.zPosition = 1
            subview.isUserInteractionEnabled = false
        }
        
        mainViewController.viewpager.subviews[index].layer.zPosition = 99
        mainViewController.viewpager.subviews[index].isUserInteractionEnabled = true
    }
    
    func addFragment(_ vc: UIViewController, position: Int) {
        var mainViewController: MainViewController!
        for viewController in viewControllers {
            if viewController is MainViewController {
                mainViewController = viewController as? MainViewController
                break
            }
        }
        if mainViewController == nil { return }
        mainViewController.viewpager.insertSubview(vc.view, at: position)
        mainViewController.addChild(vc)
        DispatchQueue.main.async {
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: mainViewController.viewpager.leadingAnchor),
                vc.view.topAnchor.constraint(equalTo: mainViewController.viewpager.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: mainViewController.viewpager.bottomAnchor),
                vc.view.trailingAnchor.constraint(equalTo: mainViewController.viewpager.trailingAnchor)
            ])
        }
    }
}
