//
//  ProductDetailUseCase.swift
//  Gomi Mall
//
//  Created by KHOI LE on 5/28/21.
//  Copyright © 2021 GomiCorp. All rights reserved.
//

import RxSwift

protocol ProductDetailUseCaseType {
    func productDetail(_ productId: Int, accountId: Int, isMeViewThis: Int) -> Observable<Product>
}

struct ProductDetailUseCase: ProductDetailUseCaseType, GetProduct {
    let productGateway: ProductGatewayType
    
    func productDetail(_ productId: Int, accountId: Int, isMeViewThis: Int) -> Observable<Product> {
        return productGateway.detail(productId, accountId: accountId, isMeViewThis: isMeViewThis)
    }
}
