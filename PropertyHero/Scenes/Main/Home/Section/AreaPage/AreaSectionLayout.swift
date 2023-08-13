//
//  AreaSectionLayout.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

final class AreaSectionLayout: SectionLayout {
    init() {
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width/3 - 4
        let layout = LayoutOptions(
            itemSpacing: 0,
            lineSpacing: 0,
            itemsPerRow: 1,
            sectionInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            itemHeight: width/2 + 34 + 84,
            itemWidth: screenSize.width
        )
        
        super.init(sectionType: .findByArea, layout: layout, cellType: AreaSectionCell.self)
    }
}

