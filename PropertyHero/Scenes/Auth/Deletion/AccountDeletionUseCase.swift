//
//  AccountDeletionUseCase.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import RxSwift
import Dto
import ValidatedPropertyKit
import FirebaseDatabase

protocol AccountDeletionUseCaseType {
    func login(_ username: String, password: String) -> Observable<[Account]>
    func delete(_ accountId: Int, password: String) -> Observable<Bool>
    func validatePassword(_ password: String) -> ValidationResult
    func checklogin(_ accounts: [Account]) -> ValidationResult
}

struct AccountDeletionUseCase: AccountDeletionUseCaseType, Login {
    var loginGateway: LoginGatewayType
    
    func login(_ username: String, password: String) -> Observable<[Account]> {
        loginGateway.login(username, password: password)
    }
    
    func delete(_ accountId: Int, password: String) -> Observable<Bool> {
        Observable.just(true)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        if password.isEmpty {
            return .failure(ValidationError(message: "Vui lòng nhập mật khẩu"))
        } else if password.count >= 6 && password.count <= 32 {
            return .success(())
        } else {
            return .failure(ValidationError(message: "Mật khẩu phải lớn hơn 6 và nhỏ hơn 32 ký tự"))
        }
    }
    
    func checklogin(_ accounts: [Account]) -> ValidationResult {
        if accounts.isEmpty {
            return .failure(ValidationError(message: "Mật khẩu không đúng. Vui lòng thử lại"))
        } else {
            return .success(())
        }
    }
}
