//
//  CategoryGateway.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit
import RxSwift
import MGArchitecture

protocol CategoryGatewayType {
    func getBanner() -> Observable<[Banner]>
}

struct CategoryGateway: CategoryGatewayType {
    
    func getBanner() -> Observable<[Banner]> {
        let input = API.GetBannerListInput()
        
        return API.shared.getBanner(input)
            .map { $0.banners }
            .unwrap()
    }
}
