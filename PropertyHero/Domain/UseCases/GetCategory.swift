//
//  GetCategory.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import RxSwift
import MGArchitecture

protocol GetCategory {
    var categoryGateway: CategoryGatewayType { get }
}

extension GetCategory {
    func getBanner() -> Observable<[Banner]> {
        return categoryGateway.getBanner()
    }
    
    func getPowerLink(_ provinceId: Int) -> Observable<[Relocation]> {
        return categoryGateway.getPowerLink(provinceId)
    }
}
