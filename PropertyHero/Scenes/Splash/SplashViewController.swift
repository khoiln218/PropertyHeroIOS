//
//  MainViewController.swift
//  BaoDongThap
//
//  Created by KHOI LE on 9/20/22.
//

import UIKit
import Reusable
import SDWebImage
import RxSwift
import RxCocoa
import MGArchitecture

final class SplashViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties

    var viewModel: SplashViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        let input = SplashViewModel.Input()
        _ = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension SplashViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.splash
}
