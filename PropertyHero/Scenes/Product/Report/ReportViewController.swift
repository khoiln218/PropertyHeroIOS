//
//  ReportViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/24/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class ReportViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: ReportViewModel!
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
        title = "Báo thông tin ảo"
    }
    
    func bindViewModel() {
        let input = ReportViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension ReportViewController {
    
}

// MARK: - StoryboardSceneBased
extension ReportViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
