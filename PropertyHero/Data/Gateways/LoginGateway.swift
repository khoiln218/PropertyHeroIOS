//
//  LoginGateway.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import UIKit
import RxSwift
import MGArchitecture

protocol LoginGatewayType {
    func login(_ username: String, password: String) -> Observable<[Account]>
}

struct LoginGateway: LoginGatewayType {
    
    func login(_ username: String, password: String) -> Observable<[Account]> {
        let input = API.LoginInput(username, password: password)
        
        return API.shared.login(input)
            .map { $0.accounts }
            .unwrap()
    }
}
