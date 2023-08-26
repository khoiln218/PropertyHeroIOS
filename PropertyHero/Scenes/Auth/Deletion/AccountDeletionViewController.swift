//
//  AccountDeletionViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/26/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then
import Dto
import FirebaseDatabase

final class AccountDeletionViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    // MARK: - Properties
    
    var viewModel: AccountDeletionViewModel!
    var disposeBag = DisposeBag()
    var ref: DatabaseReference!
    
    let account: Account = AccountStorage().getAccount()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeBackButtonTitle()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        deleteBtn.layer.cornerRadius = 3
        deleteBtn.layer.masksToBounds = true
        
        title = "Xác nhận xóa tài khoản"
        
        self.ref = Database.database(url: "https://property-hero-460a8-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    }
    
    func bindViewModel() {
        let input = AccountDeletionViewModel.Input(
            account: Driver.just(self.account),
            password: password.rx.text.orEmpty.asDriver(),
            delete: deleteBtn.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$isSuccessful
            .asDriver()
            .drive(onNext: { [unowned self] isSuccessful in
                if let isSuccessfull = isSuccessful {
                    if isSuccessfull {
                        self.ref.child("account").child("deletion").child(String(self.account.Id)).getData(completion:  { [unowned self] error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                self.onFails()
                                return
                            }
                            if let account = snapshot?.value as? [String: Any] {
                                print(account)
                                self.onFails()
                            } else {
                                self.onSuccess()
                            }
                        });
                    } else {
                        self.onFails()
                    }
                }
            })
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
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.ref.child("account").child("deletion").child(String(self.account.Id)).setValue(["username": self.account.UserName])
            self.onLogout()
            self.showAutoCloseMessage(image: nil, title: nil, message: "Xóa thành công") {
                self.viewModel.navigator.backHome()
            }
        }
    }
    
    func onFails() {
        DispatchQueue.main.async {
            self.showAutoCloseMessage(image: nil, title: nil, message: "Xảy ra lỗi. Vui lòng thử lại")
        }
    }
    
    func onLogout() {
        AccountStorage().logout()
        NotificationCenter.default.post(
            name: Notification.Name.logout,
            object: nil)
    }
}

// MARK: - Binders
extension AccountDeletionViewController {
    var passwordValidationBinder: Binder<ValidationResult> {
        return Binder(self) { vc, result in
            let viewModel = ValidationResultViewModel(validationResult: result)
            vc.password.backgroundColor = viewModel.backgroundColor
            vc.passwordError.text = viewModel.text
        }
    }
}

// MARK: - StoryboardSceneBased
extension AccountDeletionViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.auth
}
