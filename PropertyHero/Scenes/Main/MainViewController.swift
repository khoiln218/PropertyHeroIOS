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
    private var isInit = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isInit {
            self.viewModel.navigator.initMain(self)
            self.isInit = true
        }
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
            $0.backgroundBtnColor = UIColor(hex: "#424242")!
            $0.currentBackgroundBtnColor = UIColor(hex: "#2b50f6")!
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
    }
}

extension MainViewController: TabLayoutDelegate {
    func tabLayout(tabLayout: TabLayout, index: Int) {
        switch(index){
        case 4:
            self.viewModel.navigator.toTabMenu(self, tab: .more)
        case 3:
            self.viewModel.navigator.toTabMenu(self, tab: .notification)
        case 2:
            self.viewModel.navigator.toTabMenu(self, tab: .collection)
        case 1:
            self.viewModel.navigator.toTabMenu(self, tab: .search)
        default:
            self.viewModel.navigator.toTabMenu(self, tab: .home)
        }
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
