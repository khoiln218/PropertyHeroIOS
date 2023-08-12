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
    private var propertyType: PropertyType = .all;
    
    var cameraChanged = PublishSubject<SearchInfo>()
    
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
        findBtn.layer.borderWidth = 1
        findBtn.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        findBtn.layer.cornerRadius = 3
        findBtn.layer.masksToBounds = true
        
        myLocation.layer.borderWidth = 1
        myLocation.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        myLocation.layer.cornerRadius = 3
        myLocation.layer.masksToBounds = true
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        myLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myLocationButton(_:))))
        findBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(findByAreaButton(_:))))
    }
    
    @IBAction func viewAll(_ sender: Any) {
        print("viewAll")
    }
    
    @objc func myLocationButton(_ sender: UITapGestureRecognizer) {
        print("myLocationButton")
        manager.startUpdatingLocation()
    }
    
    @objc func findByAreaButton(_ sender: UITapGestureRecognizer) {
        print("findByAreaButton")
    }
    
    func bindViewModel() {
        let input = MapViewViewModel.Input(
            cameraChaged: cameraChanged.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$extraData
            .asDriver()
            .drive(onNext: { [unowned self] extraData in
                if let extraData = extraData {
                    self.title = extraData["Title"] as? String
                    self.setupMap(extraData["Latlng"] as! CLLocationCoordinate2D)
                    self.propertyType = extraData["Type"] as! PropertyType
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
        let searchInfo = SearchInfo(startLat: "\(bounds.southWest.latitude)", startLng: "\(bounds.southWest.longitude)", endLat: "\(bounds.northEast.latitude)", endLng: "\(bounds.northEast.longitude)", distance: "0.0", propertyType: "\(self.propertyType.rawValue)", status: "\(Constants.undefined.rawValue)")
        self.cameraChanged.onNext(searchInfo)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        if marker.userData is GMUCluster {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
            print("Did tap cluster")
            return true
        }
        
        print("Did tap a normal marker")
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
