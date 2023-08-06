//
//  HomeUseCase.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import RxSwift

protocol HomeUseCaseType {
    func getBanner() -> Observable<[Banner]>
}

struct HomeUseCase: HomeUseCaseType, GetCategory {
    var categoryGateway: CategoryGatewayType
    
    func getBanner() -> Observable<[Banner]> {
        return categoryGateway.getBanner()
    }
}
