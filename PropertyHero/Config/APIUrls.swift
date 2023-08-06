//
//  APIUrls.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

extension API {
    enum Urls {
        static let BaseUrl = "https://hellorentapi.gomimall.vn/"
        
        // EndPoint Utilities
        static let apiUtil = BaseUrl + "api/Utilities/"
        static let getBanner = apiUtil + "ListMainBanner"
    }
}
