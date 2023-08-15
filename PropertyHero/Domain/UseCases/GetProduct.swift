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
    func search(_ searchInfo: SearchInfo) -> Observable<PagingInfo<Product>> {
        return productGateway.search(searchInfo)
    }
    
    func detail(_ productId: Int, accountId: Int, isMeViewThis: Int) -> Observable<Product> {
        return productGateway.detail(productId, accountId: accountId, isMeViewThis: isMeViewThis)
    }
}
