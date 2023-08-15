//
//  API+Product.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/10/23.
//

import ObjectMapper
import RxSwift
import MGAPIService

extension API {
    func productSearch(_ input: ProductSearchInput) -> Observable<ProductSearchOutput> {
        return request(input)
    }
    
    func productDetail(_ input: ProductDetailInput) -> Observable<ProductDetailOutput> {
        return request(input)
    }
}

extension API {
    final class ProductDetailInput: APIUploadInputBase {
        init(_ productId: Int, accountId: Int, isMeViewThis: Int) {
            let params: JSONDictionary = [
                "ProductID": productId,
                "AccountID": accountId,
                "IsMeViewThis": isMeViewThis,
                "LanguageType": 0
            ]
            super.init(data: [], urlString: API.Urls.productDetail,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
    
    final class ProductDetailOutput: APIOutput {
        private(set) var products: [Product]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            products <- map["DataList"]
        }
    }
    
    final class ProductSearchInput: APIUploadInputBase {
        init(_ searchInfo: SearchInfo) {
            let params: JSONDictionary = [
                "StartLat": searchInfo.startLat,
                "StartLng": searchInfo.startLng,
                "EndLat": searchInfo.endLat,
                "EndLng": searchInfo.endLng,
                "Distance": searchInfo.distance,
                "PropertyType": searchInfo.propertyType,
                "PropertyID": searchInfo.propertyID,
                "MinPrice": searchInfo.minPrice,
                "MaxPrice": searchInfo.maxPrice,
                "MinArea": searchInfo.minArea,
                "MaxArea": searchInfo.maxArea,
                "Bedroom": searchInfo.bed,
                "Bathroom": searchInfo.bath,
                "Status": searchInfo.status,
                "PageNo": searchInfo.pageNo,
                "LanguageType": 0,
            ]
            super.init(data: [], urlString: API.Urls.productSearch,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
    
    final class ProductSearchOutput: APIOutput {
        private(set) var products: [Product]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            products <- map["DataList"]
        }
    }
}
