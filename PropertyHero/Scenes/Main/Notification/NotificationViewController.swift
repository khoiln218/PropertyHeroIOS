//
//  NotificationViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class NotificationViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: NotificationViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.size.width,
                           height: self.view.frame.size.height)
        let emptyView = EmptyDataView(frame: frame)
        self.view.addSubview(emptyView)
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        let input = NotificationViewModel.Input()
        _ = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension NotificationViewController {
    
}

// MARK: - StoryboardSceneBased
extension NotificationViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
