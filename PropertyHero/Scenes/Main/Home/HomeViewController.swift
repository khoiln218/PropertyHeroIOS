//
//  HomeViewController.swift
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

final class HomeViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    
    var sections = [Int: Any]()
    
    static let sectionLayoutDictionary: [SectionType: SectionLayout] = {
        let sectionLayouts = [
            HeaderSectionLayout(),
        ]
        
        var sectionLayoutDictionary = [SectionType: SectionLayout]()
        
        for layout in sectionLayouts {
            sectionLayoutDictionary[layout.sectionType] = layout
        }
        
        return sectionLayoutDictionary
    }()
    
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
        // register cells
        for layout in HomeViewController.sectionLayoutDictionary.values {
            collectionView.register(cellType: layout.cellType.self)
        }
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$sections
            .asDriver()
            .drive(onNext: { [unowned self] sections in
                self.sections = sections
                self.collectionView.reloadData()
            })
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
        
        output.$isEmpty
            .asDriver()
            .drive(collectionView.isEmpty)
            .disposed(by: disposeBag)
    }
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            for: indexPath,
            cellType: HeaderPageItemCell.self
        )
        .then {
            $0.bindViewModel(sections[indexPath.row] as! PageSectionViewModel<Banner>)
            $0.selectBanner = { banner in
                print(banner)
            }
            
            $0.selectOption = { option in
                switch(option) {
                case .all:
                    print("all clicked")
                case .apartment:
                    print("apartment clicked")
                case .room:
                    print("room clicked")
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = HomeViewController.sectionLayoutDictionary[.banner]!.layout
        return layout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - StoryboardSceneBased
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
