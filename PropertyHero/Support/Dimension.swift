//
//  Dimension.swift
//  BaoDongThap
//
//  Created by KHOI LE on 9/27/22.
//

import Foundation
import UIKit

struct Dimension {
    static var SCREEN_WIDTH: CGFloat {
        let window = UIApplication.keyWindow
        return UIScreen.main.bounds.width - window!.safeAreaInsets.left - window!.safeAreaInsets.right
    }
}
