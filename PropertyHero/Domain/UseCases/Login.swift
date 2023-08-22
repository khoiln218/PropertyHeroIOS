//
//  Login.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import RxSwift
import MGArchitecture

protocol Login {
    var loginGateway: LoginGatewayType { get }
}

extension Login {
    func login(_ username: String, password: String) -> Observable<[Account]> {
        loginGateway.login(username, password: password)
    }
    
    func verify(_ username: String) -> Observable<[Account]> {
        loginGateway.verify(username)
    }
    
    func register(_ username: String, password: String, fullname: String, phoneNumber: String) -> Observable<Bool> {
        loginGateway.register(username, password: password, fullname: fullname, phoneNumber: phoneNumber)
    }
}
