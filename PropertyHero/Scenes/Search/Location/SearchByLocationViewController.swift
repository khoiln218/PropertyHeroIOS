//
//  SearchByLocationViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/11/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then

final class SearchByLocationViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties
    
    var viewModel: SearchByLocationViewModel!
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
        let input = SearchByLocationViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension SearchByLocationViewController {
    
}

// MARK: - StoryboardSceneBased
extension SearchByLocationViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.search
}
