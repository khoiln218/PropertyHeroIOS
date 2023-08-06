//
//  GatewaysAssembler.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import UIKit

protocol GatewaysAssembler {
    func resolve() -> CategoryGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> CategoryGatewayType {
        return CategoryGateway()
    }
}
