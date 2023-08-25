//
//  ProductDetailViewController.swift
//  Gomi Mall
//
//  Created by KHOI LE on 5/28/21.
//  Copyright © 2021 GomiCorp. All rights reserved.
//

import MGArchitecture
import Reusable
import RxCocoa
import RxSwift
import UIKit
import FlexibleTable
import CoreLocation

final class ProductDetailViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var contactName: UILabel!
    private var favoriteBtn: UIButton!
    
    let titleLabel = UILabel()
    
    // MARK: - Properties
    
    var viewModel: ProductDetailViewModel!
    var disposeBag = DisposeBag()
    var product: Product!
    var relocations: [Relocation]!
    var cell = [ProductCellType]()
    private var appearance: UINavigationBarAppearance!
    
    enum ProductCellType {
        case header
        case map
        case attribute
        case feature
        case ads
        case furniture
        case footer
    }
    
    private let stickyHeaderView: UIView = {
        let headerView = UIView()
        
        let width = Dimension.SCREEN_WIDTH
        let height = width / 1.5
        
        let cover:CoverProductCell = UINib(nibName:"CoverProductCell", bundle:.main).instantiate(withOwner: nil, options: nil).first as! CoverProductCell
        cover.frame = CGRect(x: 0, y: 0, width: width, height: height)
        headerView.addSubview(cover)
        
        return headerView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let favoriteImageDefault = UIImage(named: "vector_action_favorite")
        let favoriteImageSelected = UIImage(named: "ic_drawable_like")
        favoriteBtn = UIButton(type: .custom)
        favoriteBtn.setImage(favoriteImageDefault, for: .normal)
        favoriteBtn.setImage(favoriteImageSelected, for: .selected)
        favoriteBtn.addTarget(self, action: #selector(self.favoriteClick(sender: )), for: UIControl.Event.touchUpInside)
        let shareCurrWidth = favoriteBtn.widthAnchor.constraint(equalToConstant: 28)
        shareCurrWidth.isActive = true
        let shareCurrHeight = favoriteBtn.heightAnchor.constraint(equalToConstant: 28)
        shareCurrHeight.isActive = true
        
        let stackview = UIStackView.init(arrangedSubviews: [favoriteBtn])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let newAppearance = UINavigationBarAppearance()
        newAppearance.configureWithTransparentBackground()
        removeBackButtonTitle()
        
        appearance = self.navigationController?.navigationBar.standardAppearance
        
        self.navigationController?.navigationBar.standardAppearance = newAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        self.navigationController?.navigationBar.setGradientBackground(colors: [.lightGray, .clear])
        self.navigationController?.navigationBar.tintColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = .white
        self.navigationItem.titleView = titleLabel
    }
    
    @objc func favoriteClick(sender: UIButton) {
        if !AccountStorage().isLogin() {
            viewModel.navigator.toLogin()
            return
        }
        
        if product.IsMeLikeThis == 0 {
            product.IsMeLikeThis = 1
            FavoriteStorage().insertFavorite(product)
        } else {
            product.IsMeLikeThis = 0
            FavoriteStorage().deleteFavorite(product)
        }
        favoriteBtn.isSelected = product.IsMeLikeThis == 1
        NotificationCenter.default.post(
            name: Notification.Name.favoriteChanged,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.removeGradientBackground()
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#424242")
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        callButton.layer.cornerRadius = 3
        callButton.layer.masksToBounds = true
        
        tableView.do {
            $0.dataSource = self
            $0.separatorColor = .clear
            $0.register(cellType: SummaryProductCell.self)
            $0.register(cellType: MapProductCell.self)
            $0.register(cellType: AttributeProductCell.self)
            $0.register(cellType: FeaturePageCell.self)
            $0.register(cellType: RelocationPageCell.self)
            $0.register(cellType: FurniturePageCell.self)
            $0.register(cellType: FooterProductCell.self)
            
            $0.contentInsetAdjustmentBehavior = .never
            $0.stickyHeader.view = stickyHeaderView
            $0.stickyHeader.height = Dimension.SCREEN_WIDTH / 1.5
            $0.stickyHeader.minimumHeight = 0
        }
    }
    
    @IBAction func callClick(_ sender: Any) {
        let callCenter = product.ContactPhone.isEmpty ? "0971027021" : product.ContactPhone
        guard let number = URL(string: "tel://" + callCenter) else { return }
        UIApplication.shared.open(number)
    }
    
    func bindViewModel() {
        let input = ProductDetailViewModel.Input(
            load: Driver.just(())
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$productId
            .asDriver()
            .drive(onNext: { [unowned self] productId in
                self.titleLabel.text = "Mã tin: \(productId)"
            })
            .disposed(by: disposeBag)
        
        output.$detail
            .asDriver()
            .drive(onNext: { [unowned self] detail in
                if let detail = detail {
                    if let product = detail[0] as? Product, let relocations = detail[1] as? [Relocation] {
                        if product.Id == 0 { return }
                        self.product = product
                        self.relocations = relocations
                        
                        self.product.IsMeLikeThis = FavoriteStorage().isFavorite(product.Id) ? 1 : 0
                        
                        SeenStorage().addOrUpdateSeen(self.product)
                        FavoriteStorage().updateFavorite(self.product)
                        NotificationCenter.default.post(
                            name: Notification.Name.productChanged,
                            object: nil)
                        
                        (self.stickyHeaderView.subviews[0] as? CoverProductCell)?.bindViewModel(product.Images)
                        
                        if self.product.ContactPhone.isEmpty {
                            self.phoneNumber.text = "0971-027-021"
                        } else {
                            self.phoneNumber.text = self.product.ContactPhone.substring(to: 4) + "-" + self.product.ContactPhone.substring(with: 4..<7) + "-" + self.product.ContactPhone.substring(from: 7)
                        }
                        self.contactName.text = self.product.ContactName.isEmpty ? "Property Hero" : self.product.ContactName
                        
                        self.favoriteBtn.isSelected = self.product.IsMeLikeThis == 1
                        self.cell.append(.header)
                        self.cell.append(.map)
                        self.cell.append(.attribute)
                        if !self.product.FeatureList.isEmpty {
                            self.cell.append(.feature)
                        }
                        if !self.relocations.isEmpty {
                            self.cell.append(.ads)
                        }
                        if !self.product.FurnitureList.isEmpty {
                            self.cell.append(.furniture)
                        }
                        self.cell.append(.footer)
                        self.tableView.reloadData()
                    }
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
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cell[indexPath.row]
        switch cellType {
        case .header:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: SummaryProductCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product)
            }
        case .map:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: MapProductCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product)
            }
        case .attribute:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: AttributeProductCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product)
            }
        case .feature:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: FeaturePageCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product.FeatureList)
            }
        case .ads:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: RelocationPageCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.relocations)
                $0.adsClicked = { [unowned self] relocation in
                    self.viewModel.navigator.toAds(relocation)
                }
            }
        case .furniture:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: FurniturePageCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product.FurnitureList)
            }
        case .footer:
            return tableView.dequeueReusableCell(
                for: indexPath,
                cellType: FooterProductCell.self
            )
            .then {
                $0.selectionStyle = .none
                $0.bindViewModel(self.product)
                $0.sendReport = { [unowned self] in
                    if AccountStorage().isLogin() {
                        self.viewModel.navigator.toReport(self.product.Id)
                    } else {
                        self.viewModel.navigator.toLogin()
                    }
                }
            }
        }
    }
}

// MARK: - StoryboardSceneBased
extension ProductDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}
