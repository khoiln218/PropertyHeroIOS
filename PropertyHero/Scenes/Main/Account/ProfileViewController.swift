//
//  ProfileViewController.swift
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

final class ProfileViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var avatarBtn: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userInfo: UIView!
    @IBOutlet weak var changePw: UIView!
    @IBOutlet weak var deleteBtn: UIView!
    @IBOutlet weak var logoutBtn: UIView!
    
    // MARK: - Properties
    
    var viewModel: ProfileViewModel!
    var disposeBag = DisposeBag()
    
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
        self.userInfo.addBorders(edges: [.top], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.changePw.addBorders(edges: [.top, .bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.deleteBtn.addBorders(edges: [.bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.logoutBtn.addBorders(edges: [.top, .bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.changePw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onChange(_:))))
        self.deleteBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDelete(_:))))
        self.logoutBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLogout(_:))))
        
        self.avatar.layer.borderWidth = 1.0
        self.avatar.layer.masksToBounds = false
        self.avatar.layer.borderColor = UIColor.white.cgColor
        self.avatar.layer.cornerRadius = avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        self.title = "Cá nhân"
    }
    
    @objc func onChange(_ sender: UITapGestureRecognizer) {
        self.viewModel.navigator.toChangePassword()
    }
    
    @objc func onLogout(_ sender: UITapGestureRecognizer) {
        AccountStorage().logout()
        NotificationCenter.default.post(
            name: Notification.Name.logout,
            object: nil)
        self.viewModel.navigator.backHome()
        
    }
    
    @objc func onDelete(_ sender: UITapGestureRecognizer) {
        self.viewModel.navigator.toAccountDeletion()
    }
    
    func bindViewModel() {
        let input = ProfileViewModel.Input(
            trigger: Driver.just(())
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$account
            .asDriver()
            .drive(onNext: { [unowned self] account in
                if let account = account {
                    avatar.setAvatarImage(with: URL(string: account.Avatar))
                    fullname.text = account.FullName
                    username.text = account.UserName
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension ProfileViewController {
    
}

// MARK: - StoryboardSceneBased
extension ProfileViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
