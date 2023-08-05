//
//  UIImageView+SDWebImage.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with url: URL?, completion: SDExternalCompletionBlock? = nil) {
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_placeholder"), completed: completion)
    }
    
    func setCateImage(with url: URL?, completion: SDExternalCompletionBlock? = nil) {
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "AppIcon"), completed: completion)
    }
}
