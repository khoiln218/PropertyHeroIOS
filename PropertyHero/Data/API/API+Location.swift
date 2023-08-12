//
//  API+Location.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/12/23.
//

import ObjectMapper
import RxSwift
import MGAPIService

extension API {
    func getProvince(_ input: GetProvinceListInput) -> Observable<GetProvinceListOutput> {
        return request(input)
    }
    
    func searchMarkers(_ input: SearchMarkerInput) -> Observable<SearchMarkerOutput> {
        return request(input)
    }
}

extension API {
    final class GetProvinceListInput: APIInput {
        init() {
            let urlString = String(format: API.Urls.listProvince, CountryId.vietnam.rawValue)
            super.init(urlString: urlString,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetProvinceListOutput: APIOutput {
        private(set) var provinces: [Province]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            provinces <- map["DataList"]
        }
    }
    
    final class SearchMarkerInput: APIUploadInputBase {
        init(_ keyword: String, provinceID: Int, markerType: Int) {
            let params: JSONDictionary = [
                "Keyword": keyword,
                "ProvinceID": provinceID,
                "MarkerType": markerType,
                "LanguageType": 0,
            ]
            super.init(data: [], urlString: API.Urls.markerByKeywords,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
    
    final class SearchMarkerOutput: APIOutput {
        private(set) var markers: [Marker]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            markers <- map["DataList"]
        }
    }
}
