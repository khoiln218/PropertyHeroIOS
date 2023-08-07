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
    @IBOutlet weak var mapview: UIView!
    @IBOutlet weak var findBtn: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var myLocation: UIView!
    
    // MARK: - Properties
    
    var viewModel: MapViewViewModel!
    var disposeBag = DisposeBag()
    
    let kClusterItemCount = 10000
    let kCameraLatitude = 10.771513
    let kCameraLongitude = 106.698387
    
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private let manager = CLLocationManager()
    
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
        
        let camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 17.0)
        self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.mapview.insertSubview(mapView, at: 0)
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        clusterManager.setMapDelegate(self)
        
        generateClusterItems()
        clusterManager.cluster()
        
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
        let input = MapViewViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$option
            .asDriver()
            .drive(onNext: { [unowned self] option in
                switch(option) {
                case .all:
                    title = "Tất cả"
                case .apartment:
                    title = "Căn hộ"
                case .room:
                    title = "Phòng trọ"
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func generateClusterItems() {
        let extent = 0.2
        for _ in 1...kClusterItemCount {
            let lat = kCameraLatitude + extent * randomScale()
            let lng = kCameraLongitude + extent * randomScale()
            let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let marker = GMSMarker(position: position)
            marker.icon = UIImage(named: "ic_vector_product_item")
            clusterManager.add(marker)
        }
    }
    
    /// Returns a random value between -1.0 and 1.0.
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
}

// MARK: - GMSMapViewDelegate
extension MapViewViewController: GMSMapViewDelegate {
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
        let location = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.mapView?.animate(to: camera)

        self.manager.stopUpdatingLocation()

    }
}

// MARK: - StoryboardSceneBased
extension MapViewViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.map
}
