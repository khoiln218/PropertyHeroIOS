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

final class AccountDeletionViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: AccountDeletionViewModel!
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
        
    }
    
    func bindViewModel() {
        let input = AccountDeletionViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension AccountDeletionViewController {
    
}

// MARK: - StoryboardSceneBased
extension AccountDeletionViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.auth
}
