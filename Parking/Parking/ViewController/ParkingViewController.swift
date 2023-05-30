//
//  ParkingViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreData
import CoreLocation

class ParkingViewController: UIViewController, CLLocationManagerDelegate {

    private lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.persistentContainer
    }()

    lazy var mapView = NMFMapView(frame: view.frame)
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        //MARK: - 네이버 맵 띄우기
        view.addSubview(mapView)

        //MARK: - 버튼 2개 추가
        let favoriteButton = IconButton(type: .favorite)
        let currentButton = IconButton(type: .currentLocation)
        currentButton.addTarget(self, action: #selector(tappedCurrentLocation), for: .touchUpInside)
        view.addSubview(favoriteButton)
        view.addSubview(currentButton)

        //MARK: - 서치 바
        let searchBar = SearchBar()
        view.addSubview(searchBar)

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            favoriteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37),
            favoriteButton.widthAnchor.constraint(equalToConstant: 60),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            currentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            currentButton.bottomAnchor.constraint(equalTo: favoriteButton.topAnchor, constant: -20),
            currentButton.widthAnchor.constraint(equalToConstant: 60),
            currentButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchBar.widthAnchor.constraint(equalToConstant: 335),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        //MARK: - Charge Label
//        let free = ChargeLabel()
//        free.configure(type: .free, filled: false)
//        view.addSubview(free)
//
//        free.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            free.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            free.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            free.widthAnchor.constraint(equalToConstant: 50),
//            free.heightAnchor.constraint(equalToConstant: 18)
//        ])

//        MARK: - 주차장 핀 보이기
        let request = ParkingPlace.fetchRequest()
        let parkingPlaces = try? persistentContainer.viewContext.fetch(request)
        parkingPlaces?.forEach { parkingPlace in
            if let image = UIImage(named: "ParkingPin") {
                let marker = NMFMarker()
                marker.iconImage = NMFOverlayImage(image: image)
                marker.position = NMGLatLng(lat: parkingPlace.latitude, lng: parkingPlace.longitude)
                marker.width = 30
                marker.height = 42.9
                marker.mapView = mapView
                marker.userInfo = ["data": parkingPlace]
                marker.touchHandler = { (overlay) -> Bool in
                    self.showMyViewControllerInACustomizedSheet(with: parkingPlace)
                    return true
                }
            }
        }
    }

    func showMyViewControllerInACustomizedSheet(with parkPlace: ParkingPlace) {

        let viewControllerToPresent = BottomSheetController()
        viewControllerToPresent.configure(with: parkPlace)
        print(parkPlace.favorite)
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.custom { context in return 180}]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.preferredCornerRadius = 20
        }

        present(viewControllerToPresent, animated: true, completion: nil)
    }

    @objc func tappedCurrentLocation() {
        guard mapView.positionMode != .normal else {
            mapView.positionMode = .disabled
            return
        }
        if let location = locationManager.location {
            mapView.positionMode = .normal
            let currentLocation = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: currentLocation)
            mapView.moveCamera(cameraUpdate)
        }
    }
}
