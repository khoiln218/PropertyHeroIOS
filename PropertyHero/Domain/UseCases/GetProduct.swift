//
//  GetProduct.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/10/23.
//

import RxSwift
import MGArchitecture

protocol GetProduct {
    var productGateway: ProductGatewayType { get }
}

extension GetProduct {
    func search(_ searchInfo: SearchInfo) -> Observable<[Product]> {
        return productGateway.search(searchInfo)
    }
}
