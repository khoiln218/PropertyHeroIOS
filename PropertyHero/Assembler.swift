//
//  Assembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

protocol Assembler: AnyObject,
                    ProductAssembler,
                    ProductListAssembler,
                    FavoriteAssembler,
                    ProductViewAssembler,
                    SearchByMarkerAssembler,
                    SearchByLocationAssembler,
                    MapViewAssembler,
                    HomeAssembler,
                    SearchAssembler,
                    CollectionAssembler,
                    NotificationAssembler,
                    MoreAssembler,
                    MainAssembler,
                    SplashAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
