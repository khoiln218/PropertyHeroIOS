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
}

extension API {
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
