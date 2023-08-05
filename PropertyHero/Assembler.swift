//
//  Assembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

protocol Assembler: AnyObject,
                    MainAssembler,
                    AppAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
