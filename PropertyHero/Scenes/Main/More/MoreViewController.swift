//
//  MoreViewController.swift
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

final class MoreViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var account: UIView!
    @IBOutlet weak var accountAvatar: UIImageView!
    @IBOutlet weak var accountInfo: UIStackView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var rating: UIView!
    @IBOutlet weak var feedback: UIView!
    @IBOutlet weak var myProduct: UIView!
    @IBOutlet weak var setting: UIView!
    
    // MARK: - Properties
    
    var viewModel: MoreViewModel!
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
        self.account.addBorders(edges: [.bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.rating.addBorders(edges: [.top, .bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.feedback.addBorders(edges: [.bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.myProduct.addBorders(edges: [.top, .bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        self.setting.addBorders(edges: [.top,.bottom], color: UIColor(hex: "#ECEFF1")!, width: 1)
        
        
        self.account.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAccount(_:))))
        self.rating.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRating(_:))))
        self.feedback.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFeedback(_:))))
        self.myProduct.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMyProduct(_:))))
        self.setting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSetting(_:))))
    }
    
    @objc func onAccount(_ sender: UITapGestureRecognizer) {
        coomingSoon()
        print(#function)
    }
    
    @objc func onRating(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://apps.apple.com/app/id1574177729") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func onFeedback(_ sender: UITapGestureRecognizer) {
        coomingSoon()
        print(#function)
    }
    
    @objc func onMyProduct(_ sender: UITapGestureRecognizer) {
        coomingSoon()
        print(#function)
    }
    
    @objc func onSetting(_ sender: UITapGestureRecognizer) {
        coomingSoon()
        print(#function)
    }
    
    func coomingSoon() {
        self.showAutoCloseMessage(image: nil, title: nil, message: "Sắp mở")
    }
    
    func bindViewModel() {
        let input = MoreViewModel.Input()
        _ = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension MoreViewController {
    
}

// MARK: - StoryboardSceneBased
extension MoreViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
