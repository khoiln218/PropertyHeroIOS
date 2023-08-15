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
    func search(_ seachInfo: SearchInfo) -> Observable<PagingInfo<Product>>
    func detail(_ productId: Int, accountId: Int, isMeViewThis: Int) -> Observable<Product>
}

struct ProductGateway: ProductGatewayType {
    
    func search(_ seachInfo: SearchInfo) -> Observable<PagingInfo<Product>> {
        let input = API.ProductSearchInput(seachInfo)
        
        return API.shared.productSearch(input)
            .map { $0.products }
            .unwrap()
            .map { PagingInfo(page: seachInfo.pageNo, items: $0) }
    }
    
    func detail(_ productId: Int, accountId: Int, isMeViewThis: Int) -> Observable<Product> {
        let input = API.ProductDetailInput(productId, accountId: accountId, isMeViewThis: isMeViewThis)
        
        return API.shared.productDetail(input)
            .map { $0.products }
            .unwrap()
            .map { $0.count > 0 ? $0[0] : Product() }
    }
}
