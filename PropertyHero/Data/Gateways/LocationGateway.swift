//
//  LocationGateway.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/12/23.
//

import UIKit
import RxSwift
import MGArchitecture

protocol LocationGatewayType {
    func getProvinces() -> Observable<[Province]>
    
    func searchMarkers(_ keyword: String, provinceID: Int, markerType: Int) -> Observable<[Marker]>
}

struct LocationGateway: LocationGatewayType {
    
    func getProvinces() -> Observable<[Province]> {
        let input = API.GetProvinceListInput()
        
        return API.shared.getProvince(input)
            .map { $0.provinces }
            .unwrap()
    }
    
    func searchMarkers(_ keyword: String, provinceID: Int, markerType: Int) -> Observable<[Marker]> {
        let input = API.SearchMarkerInput(keyword, provinceID: provinceID, markerType: markerType)
        
        return API.shared.searchMarkers(input)
            .map { $0.markers }
            .unwrap()
    }
}
