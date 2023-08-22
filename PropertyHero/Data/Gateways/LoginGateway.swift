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
    func verify(_ username: String) -> Observable<[Account]>
    func register(_ username: String, password: String, fullname: String, phoneNumber: String) -> Observable<Bool>
}

struct LoginGateway: LoginGatewayType {
    
    func login(_ username: String, password: String) -> Observable<[Account]> {
        let input = API.LoginInput(username, password: password)
        
        return API.shared.login(input)
            .map { $0.accounts }
            .unwrap()
    }
    
    func verify(_ username: String) -> Observable<[Account]>{
        let input = API.VerifyInput(username)
        
        return API.shared.verify(input)
            .map { $0.accounts }
            .unwrap()
    }
    
    func register(_ username: String, password: String, fullname: String, phoneNumber: String) -> Observable<Bool> {
        let input = API.RegisterInput(username, password: password, fullname: fullname, phoneNumber: phoneNumber)
        
        return API.shared.register(input)
            .map { $0.success }
            .unwrap()
    }
}
