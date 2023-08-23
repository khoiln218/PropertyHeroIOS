//
//  API+Category.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import ObjectMapper
import RxSwift
import MGAPIService

extension API {
    func getBanner(_ input: GetBannerListInput) -> Observable<GetBannerListOutput> {
        return request(input)
    }
    
    func getPowerLink(_ input: GetPowerLinkInput) -> Observable<GetPowerLinkOutput> {
        return request(input)
    }
}

extension API {
    final class GetPowerLinkInput: APIInput {
        init(_ provinceId: Int) {
            let urlString = String(format: API.Urls.powerLink, provinceId)
            super.init(urlString: urlString,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetPowerLinkOutput: APIOutput {
        private(set) var relocations: [Relocation]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            relocations <- map["DataList"]
        }
    }
    
    final class GetBannerListInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getBanner,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetBannerListOutput: APIOutput {
        private(set) var banners: [Banner]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            banners <- map["DataList"]
        }
    }
}
