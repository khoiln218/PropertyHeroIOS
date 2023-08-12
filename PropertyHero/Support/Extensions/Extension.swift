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
    func showViewControllerInMain(_ tagert: MainViewController, tab: TabMenu) {
        for subview in tagert.viewpager.subviews {
            subview.layer.zPosition = 1
            subview.isUserInteractionEnabled = false
        }
        tagert.viewpager.subviews[tab.rawValue].layer.zPosition = 99
        tagert.viewpager.subviews[tab.rawValue].isUserInteractionEnabled = true
    }
    
    func addFragmentToMain(_ tagert: MainViewController, vc: UIViewController, tab: TabMenu) {
        tagert.viewpager.insertSubview(vc.view, at: tab.rawValue)
        tagert.addChild(vc)
        DispatchQueue.main.async {
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: tagert.viewpager.leadingAnchor),
                vc.view.topAnchor.constraint(equalTo: tagert.viewpager.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: tagert.viewpager.bottomAnchor),
                vc.view.trailingAnchor.constraint(equalTo: tagert.viewpager.trailingAnchor)
            ])
        }
    }
}

extension UINavigationController {
    func showViewControllerInSearch(_ tagert: SearchViewController, tab: TabSearch) {
        for subview in tagert.viewpager.subviews {
            subview.layer.zPosition = 1
            subview.isUserInteractionEnabled = false
        }
        tagert.viewpager.subviews[tab.rawValue].layer.zPosition = 99
        tagert.viewpager.subviews[tab.rawValue].isUserInteractionEnabled = true
    }
    
    func addFragmentToSearch(_ tagert: SearchViewController, vc: UIViewController, tab: TabSearch) {
        tagert.viewpager.insertSubview(vc.view, at: tab.rawValue)
        DispatchQueue.main.async {
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            tagert.addChild(vc)
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: tagert.viewpager.leadingAnchor),
                vc.view.topAnchor.constraint(equalTo: tagert.viewpager.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: tagert.viewpager.bottomAnchor),
                vc.view.trailingAnchor.constraint(equalTo: tagert.viewpager.trailingAnchor)
            ])
        }
    }
}
