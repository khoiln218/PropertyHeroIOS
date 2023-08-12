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
        
        // Utilities
        static let apiUtil = BaseUrl + "api/Utilities/"
        static let getBanner = apiUtil + "ListMainBanner"
        
        // Location
        static let apiLocation = BaseUrl + "api/Location/"
        static let listProvince = apiLocation + "ListProvince/CountryID=%d/"
        static let markerByKeywords = apiLocation + "ListMarkerByKeyword"
    }
}
