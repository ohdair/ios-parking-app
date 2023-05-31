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

    let favoriteButton = IconButton(type: .favorite)
    let currentButton = IconButton(type: .currentLocation)

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        //MARK: - 네이버 맵 띄우기
        view.addSubview(mapView)

        favoriteButton.addTarget(self, action: #selector(tappedFavorite), for: .touchUpInside)
        currentButton.addTarget(self, action: #selector(tappedCurrentLocation), for: .touchUpInside)
        view.addSubview(favoriteButton)
        view.addSubview(currentButton)

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
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: parkingPlace.latitude,
                                                                           lng: parkingPlace.longitude),
                                                       zoomTo: 15)
                    cameraUpdate.animation = .fly
                    cameraUpdate.animationDuration = 1.0
                    self.mapView.moveCamera(cameraUpdate)
                    self.showMyViewControllerInACustomizedSheet(with: parkingPlace)
                    return true
                }
            }
        }

        setAutoLayout()
    }

    private func setAutoLayout() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        currentButton.translatesAutoresizingMaskIntoConstraints = false

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
    }

    func showMyViewControllerInACustomizedSheet(with parkPlace: ParkingPlace) {

        let viewControllerToPresent = BottomSheetController()
        viewControllerToPresent.configure(with: parkPlace)
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

    @objc func tappedFavorite() {
        let nextViewController = FavoriteViewController()
        nextViewController.delegate = self
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension ParkingViewController: FavoriteViewControllerDelegate {
    func cameraUpdate(with coordinate: Coordinate) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude,
                                                               lng: coordinate.longitude),
                                           zoomTo: 15)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1.0
        self.mapView.moveCamera(cameraUpdate)
    }
}
