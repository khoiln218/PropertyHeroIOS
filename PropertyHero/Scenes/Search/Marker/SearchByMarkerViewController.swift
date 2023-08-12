//
//  SearchByMarkerViewController.swift
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

final class SearchByMarkerViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var filterBar: UIView!
    @IBOutlet weak var searchBar: DesignableUITextField!
    @IBOutlet weak var provinceBtn: UIView!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: SearchByMarkerViewModel!
    var disposeBag = DisposeBag()
    
    private var provinces = [Province]()
    private var markers = [Marker]()
    private var provinceSelected:Province!
    
    var provinceSubject = PublishSubject<Province>()
    var keywordSubject = PublishSubject<String>()
    
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
        tableView.do {
            $0.dataSource = self
            $0.register(cellType: MarkerCell.self)
        }
        
        filterBar.layer.borderWidth = 0.3
        filterBar.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        filterBar.layer.masksToBounds = true
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        searchBar.layer.cornerRadius = 3
        searchBar.layer.masksToBounds = true
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        
        provinceBtn.layer.borderWidth = 1
        provinceBtn.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        provinceBtn.layer.cornerRadius = 3
        provinceBtn.layer.masksToBounds = true
        
        provinceBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectedProvince(_:))))
    }
    
    @objc func onSelectedProvince(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "   ", message: "   ", preferredStyle: .actionSheet)
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
         let messageString = NSAttributedString(string: "Chọn Tỉnh/Thành phố", attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        
        for province in self.provinces {
            alert.addAction(UIAlertAction(title: province.Name, style: .default , handler:{ [unowned self] _ in
                self.provinceSelected = province
                self.provinceSubject.onNext(self.provinceSelected)
                self.provinceLabel.text = province.Name
            }))
        }
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func bindViewModel() {
        let input = SearchByMarkerViewModel.Input(
            trigger: Driver.just(()),
            province: provinceSubject.asDriverOnErrorJustComplete(),
            keyword: keywordSubject.asDriverOnErrorJustComplete(),
            selectMarker: tableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$proinces
            .asDriver()
            .drive(onNext: { [unowned self] provinces in
                if let provinces = provinces {
                    self.provinceSelected = provinces.first{ $0.Id == 2 } ?? provinces.first
                    self.provinceSubject.onNext(self.provinceSelected)
                    self.provinceLabel.text = self.provinceSelected.Name
                    self.provinces = provinces
                }
            })
            .disposed(by: disposeBag)
        
        output.$markers
            .asDriver()
            .drive(onNext: { [unowned self] markers in
                if let markers = markers {
                    self.markers = markers
                    self.tableView.reloadData()
                }
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
            .drive(tableView.isEmpty)
            .disposed(by: disposeBag)
    }
}

extension SearchByMarkerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let marker = self.markers[indexPath.row]
        return tableView.dequeueReusableCell(
            for: indexPath,
            cellType: MarkerCell.self
        )
        .then {
            $0.selectionStyle = .none
            $0.bindViewModel(marker)
        }
    }
}

extension SearchByMarkerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchBar {
            if let keyword = textField.text {
                self.keywordSubject.onNext(keyword)
            }
            textField.resignFirstResponder()
            return true
        }
        return false
    }
}

// MARK: - StoryboardSceneBased
extension SearchByMarkerViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.search
}
