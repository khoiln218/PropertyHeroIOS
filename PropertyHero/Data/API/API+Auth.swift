//
//  API+Auth.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import ObjectMapper
import RxSwift
import MGAPIService

extension API {
    
    func login(_ input: LoginInput) -> Observable<LoginOutput> {
        return request(input)
    }
}

extension API {
    
    final class LoginInput: APIUploadInputBase {
        init(_ username: String, password: String) {
            let params: JSONDictionary = [
                "UserName": username,
                "Password": password,
                "Token": "",
                "DeviceType": "",
                "Version": "",
                "Address": "",
                "Latitude": "",
                "Longitude": ""
            ]
            super.init(data: [], urlString: API.Urls.login,
                       parameters: params,
                       method: .post,
                       requireAccessToken: true)
        }
    }
    
    final class LoginOutput: APIOutput {
        private(set) var accounts: [Account]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            accounts <- map["DataList"]
        }
    }
}
