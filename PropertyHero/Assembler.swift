//
//  Assembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

protocol Assembler: AnyObject,
                    MainAssembler,
                    SplashAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
