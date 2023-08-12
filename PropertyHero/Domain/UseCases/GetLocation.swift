//
//  GetLocation.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/12/23.
//

import RxSwift
import MGArchitecture

protocol GetLocation {
    var locationGateway: LocationGatewayType { get }
}

extension GetLocation {
    func getProvinces() -> Observable<[Province]> {
        return locationGateway.getProvinces()
    }
    
    func searchMarkers(_ keyword: String, provinceID: Int, markerType: Int) -> Observable<[Marker]> {
        return locationGateway.searchMarkers(keyword, provinceID: provinceID, markerType: markerType)
    }
}
