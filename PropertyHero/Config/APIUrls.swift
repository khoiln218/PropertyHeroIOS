//
//  APIUrls.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

extension API {
    enum Urls {
        static let BaseUrl = "https://hellorentapi.gomimall.vn/"
        
        // Product
        static let apiProduct = BaseUrl + "api/Product/"
        static let search = apiProduct + "Search"
        
        // EndPoint Utilities
        static let apiUtil = BaseUrl + "api/Utilities/"
        static let getBanner = apiUtil + "ListMainBanner"
    }
}
