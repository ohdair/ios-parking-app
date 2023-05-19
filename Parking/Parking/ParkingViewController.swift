//
//  ParkingViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import UIKit
import NMapsMap

class ParkingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
}
