//
//  MainViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import UIKit
import Reusable
import SDWebImage
import RxSwift
import RxCocoa
import MGArchitecture
import Then

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tabLayout: TabLayout!
    @IBOutlet weak var viewpager: UIView!
    
    // MARK: - Properties

    var viewModel: MainViewModel!
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
        tabLayout.do {
            $0.tabLayoutDelegate = self
            $0.indicatorSize = 0.0
            $0.fixedMode = true
        }
        
        var tabs = [(title: String?, image: UIImage?)]()
        tabs.append((title: "", UIImage(named: "ic_action_home")))
        tabs.append((title: "", UIImage(named: "ic_action_search")))
        tabs.append((title: "", UIImage(named: "ic_action_collection")))
        tabs.append((title: "", UIImage(named: "ic_action_notification")))
        tabs.append((title: "", UIImage(named: "ic_action_more")))
        tabLayout.addTabs(tabs: tabs)
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input()
        _ = viewModel.transform(input, disposeBag: disposeBag)
        self.viewModel.navigator.initMain()
    }
}

extension MainViewController: TabLayoutDelegate {
    func tabLayout(tabLayout: TabLayout, index: Int) {
        self.viewModel.navigator.toMenu(index)
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
