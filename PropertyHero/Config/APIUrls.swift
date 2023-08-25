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
        static let apiProduct = BaseUrl + "api/v2.0/Product/"
        static let productSearch = apiProduct + "Search"
        static let productDetail = apiProduct + "GetByID"
        
        // Utilities
        static let apiUtil = BaseUrl + "api/Utilities/"
        static let getBanner = apiUtil + "ListMainBanner"
        static let powerLink = apiUtil + "ListPowerLink/ProvinceID=%d/"
        static let sendWarning = apiUtil + "SendWarning"
        
        // Location
        static let apiLocation = BaseUrl + "api/Location/"
        static let listProvince = apiLocation + "ListProvince/CountryID=%d/"
        static let listDistrict = apiLocation + "ListDistrict/ProvinceID=%d/"
        static let markerByKeywords = apiLocation + "ListMarkerByKeyword"
        static let markerByLocation = apiLocation + "ListAttractionByLocation/Latitude=%f/Longitude=%f/NumItems=%d/Language=%d/"
        static let markerByUniversity = apiLocation + "ListUniversityInKorea/NumItems=%d/Language=%d/"
        
        //Auth
        static let apiAuth = BaseUrl + "api/Account/"
        static let login = apiAuth + "AccountLogin"
        static let verify = apiAuth + "Verify/UserName=%@/"
        static let register = apiAuth + "MemberRegistration"
    }
}
