//
//  LoginViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/20/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then
import Dto

final class LoginViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    // MARK: - Properties
    
    var viewModel: LoginViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        loginBtn.layer.cornerRadius = 3
        loginBtn.layer.masksToBounds = true
        
        title = "Đăng nhập"
    }
    
    @IBAction func registerMember(_ sender: Any) {
        self.viewModel.navigator.toRegister()
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(
                trigger: Driver.just(()),
                username: username.rx.text.orEmpty.asDriver(),
                password: password.rx.text.orEmpty.asDriver(),
                login: loginBtn.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$usernameValidation
            .asDriver()
            .drive(usernameValidationBinder)
            .disposed(by: disposeBag)
        
        output.$passwordValidation
            .asDriver()
            .drive(passwordValidationBinder)
            .disposed(by: disposeBag)
        
        output.$error
            .asDriver()
            .unwrap()
            .drive(rx.error)
            .disposed(by: disposeBag)
        
        output.$isLoading
            .asDriver()
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension LoginViewController {
    var usernameValidationBinder: Binder<ValidationResult> {
        return Binder(self) { vc, result in
            let viewModel = ValidationResultViewModel(validationResult: result)
            vc.username.backgroundColor = viewModel.backgroundColor
            vc.usernameError.text = viewModel.text
        }
    }
    
    var passwordValidationBinder: Binder<ValidationResult> {
        return Binder(self) { vc, result in
            let viewModel = ValidationResultViewModel(validationResult: result)
            vc.password.backgroundColor = viewModel.backgroundColor
            vc.passwordError.text = viewModel.text
        }
    }
}

// MARK: - StoryboardSceneBased
extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.auth
}
