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
    func getPowerLink(_ provinceId: Int) -> Observable<[Relocation]>
}

struct CategoryGateway: CategoryGatewayType {
    
    func getBanner() -> Observable<[Banner]> {
        let input = API.GetBannerListInput()
        
        return API.shared.getBanner(input)
            .map { $0.banners }
            .unwrap()
    }
    
    func getPowerLink(_ provinceId: Int) -> Observable<[Relocation]> {
        let input = API.GetPowerLinkInput(provinceId)
        
        return API.shared.getPowerLink(input)
            .map { $0.relocations }
            .unwrap()
    }
}
