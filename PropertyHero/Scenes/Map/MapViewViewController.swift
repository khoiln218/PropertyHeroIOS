//
//  MapViewViewController.swift
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
import GoogleMaps
import GoogleMapsUtils

final class MapViewViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var findBtn: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var myLocation: UIView!
    @IBOutlet weak var numItems: UILabel!
    
    // MARK: - Properties
    
    var viewModel: MapViewViewModel!
    var disposeBag = DisposeBag()
    
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private let geocoder = GMSGeocoder()
    private let manager = CLLocationManager()
    
    var cameraChanged = PublishSubject<GMSCoordinateBounds>()
    var viewmore = PublishSubject<Void>()
    var filter = PublishSubject<Void>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeBackButtonTitle()
        
        let filterBtn = UIButton(type: .custom)
        filterBtn.setImage(UIImage(named: "vector_action_filter")!, for: .normal)
        filterBtn.addTarget(self, action: #selector(self.filterClick(_:)), for: UIControl.Event.touchUpInside)
        let filterCurrWidth = filterBtn.widthAnchor.constraint(equalToConstant: 24)
        filterCurrWidth.isActive = true
        let filterCurrHeight = filterBtn.heightAnchor.constraint(equalToConstant: 24)
        filterCurrHeight.isActive = true
        
        let rightBarButton = UIBarButtonItem(customView: filterBtn)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        findBtn.layer.borderWidth = 1
        findBtn.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        findBtn.layer.cornerRadius = 3
        findBtn.layer.masksToBounds = true
        
        myLocation.layer.borderWidth = 1
        myLocation.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        myLocation.layer.cornerRadius = 3
        myLocation.layer.masksToBounds = true
        
        viewAllBtn.layer.cornerRadius = 3
        viewAllBtn.layer.masksToBounds = true
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        myLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myLocationButton(_:))))
        findBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(findByMarkerButton(_:))))
    }
    
    @IBAction func viewAllDragOutside(_ sender: Any) {
        viewAllBtn.backgroundColor = UIColor(hex: "#2B50F6")!
    }
    
    @IBAction func viewAllPressed(_ sender: Any) {
        viewAllBtn.backgroundColor = UIColor(hex: "#FFA000")!
    }
    
    @IBAction func viewAll(_ sender: Any) {
        viewAllBtn.backgroundColor = UIColor(hex: "#2B50F6")!
        self.viewmore.onNext(())
    }
    
    @objc func filterClick(_ sender: Any) {
        self.filter.onNext(())
    }
    
    @objc func myLocationButton(_ sender: UITapGestureRecognizer) {
        manager.startUpdatingLocation()
    }
    
    @objc func findByMarkerButton(_ sender: UITapGestureRecognizer) {
        self.viewModel.navigator.toSearchByMarker()
    }
    
    func bindViewModel() {
        let input = MapViewViewModel.Input(
            filter: filter.asDriverOnErrorJustComplete(),
            cameraChaged: cameraChanged.asDriverOnErrorJustComplete(),
            viewmore: viewmore.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$title
            .asDriver()
            .drive(onNext: { [unowned self] title in
                if let title = title {
                    self.title = title
                }
            })
            .disposed(by: disposeBag)
        
        output.$latlng
            .asDriver()
            .drive(onNext: { [unowned self] latlng in
                if let latlng = latlng {
                    self.setupMap(latlng)
                }
            })
            .disposed(by: disposeBag)
        
        output.$products
            .asDriver()
            .drive(onNext: { [unowned self] products in
                self.numItems.text = "\(products.count)\("unit_item".localized())";
                self.createClusterItems(products)
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
    
    private func setupMap(_ latlng: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: latlng.latitude, longitude: latlng.longitude, zoom: DefaultStorage().getMapZoom())
        
        self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.container.insertSubview(mapView, at: 0)
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        clusterManager.setMapDelegate(self)
    }
    
    private func createClusterItems(_ products: [Product]) {
        self.clusterManager.clearItems()
        for product in products {
            let position = CLLocationCoordinate2D(latitude: product.Latitude, longitude: product.Longitude)
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "ic_vector_product_item")
            marker.userData = product
            clusterManager.add(marker)
        }
        self.clusterManager.cluster()
    }
}

// MARK: - GMSMapViewDelegate
extension MapViewViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) { 
        if mapView.camera.zoom <= 7 { return }
        
        let camView = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(region: camView)
        DefaultStorage().setLastLatLng(cameraPosition.target.latitude, lng: cameraPosition.target.longitude, zoom: cameraPosition.zoom)
        self.cameraChanged.onNext(bounds)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        if marker.userData is GMUCluster {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
            print("Did tap cluster")
            return true
        }
        
        self.viewModel.navigator.toProductDetail((marker.userData as! Product).Id)
        return false
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude, zoom: DefaultStorage().getMapZoom())
        self.mapView.animate(to: camera)
    }
}

// MARK: - StoryboardSceneBased
extension MapViewViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.map
}
