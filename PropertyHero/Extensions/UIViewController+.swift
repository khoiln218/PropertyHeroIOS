//
//  UIViewController+.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showError(message: String, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showAutoCloseMessage(image: UIImage?,
                              title: String?,
                              message: String?,
                              interval: TimeInterval = 2,
                              completion: (() -> Void)? = nil) {
        if let image = image {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .customView
            hud.customView = UIImageView(image: image)
            hud.label.text = title
            hud.detailsLabel.text = message
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                MBProgressHUD.hide(for: self.view, animated: true)
                completion?()
            }
        } else {
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                ac.dismiss(animated: true, completion: completion)
            }
            
            present(ac, animated: true, completion: nil)
        }
    }
}
