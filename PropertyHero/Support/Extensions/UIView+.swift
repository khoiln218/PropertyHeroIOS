//
//  UIView+.swift
//  BaoDongThap
//
//  Created by KHOI LE on 10/23/22.
//

import UIKit

extension UIView {
    
    func hidden(gone: Bool = false) -> Void {
        if gone {
            self.constraints.filter{ $0.firstAttribute == .width && $0.relation == .equal && $0.secondAttribute == .notAnAttribute }.forEach( {$0.constant = 0 })
            self.constraints.filter{ $0.firstAttribute == .height && $0.relation == .equal && $0.secondAttribute == .notAnAttribute }.forEach( {$0.constant = 0 })
            self.layoutIfNeeded()
        }
        self.isHidden = true
    }
    
    func visible(width: CGFloat = 0, height: CGFloat = 0) -> Void {
        if width > 0 {
            self.constraints.filter{ $0.firstAttribute == .width && $0.relation == .equal && $0.secondAttribute == .notAnAttribute }.forEach( {$0.constant = width })
        }
        if height > 0 {
            self.constraints.filter{ $0.firstAttribute == .height && $0.relation == .equal && $0.secondAttribute == .notAnAttribute }.forEach( {$0.constant = height })
        }
        self.layoutIfNeeded()
        self.isHidden = false
    }
}
