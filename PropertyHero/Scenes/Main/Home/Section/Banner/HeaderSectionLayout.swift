//
//  HeaderSectionLayout.swift
//  CleanArchitecture
//
//  Created by KHOI LE on 5/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

import UIKit

final class HeaderSectionLayout: SectionLayout {
    init() {
        let screenSize: CGRect = UIScreen.main.bounds
        let layout = LayoutOptions(
            itemSpacing: 0,
            lineSpacing: 0,
            itemsPerRow: 1,
            sectionInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            itemHeight: screenSize.width / 2 + 112,
            itemWidth: 0
        )
        
        super.init(sectionType: .banner, layout: layout, cellType: HeaderPageItemCell.self)
    }
}
