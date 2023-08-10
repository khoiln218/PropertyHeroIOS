//
//  ProductGateway.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/10/23.
//

import UIKit
import RxSwift
import MGArchitecture

protocol ProductGatewayType {
    func search(_ seachInfo: SearchInfo) -> Observable<[Product]>
}

struct ProductGateway: ProductGatewayType {
    
    func search(_ seachInfo: SearchInfo) -> Observable<[Product]> {
        let input = API.ProductSearchInput(seachInfo)
        
        return API.shared.search(input)
            .map { $0.products }
            .unwrap()
    }
}
