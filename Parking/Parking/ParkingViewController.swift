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

//        let mapView = NMFMapView(frame: view.frame)
//        view.addSubview(mapView)

        do {
            let parkingPlaceAPI = ParkingPlaceAPI()
            let request = try EndPoint(parkingPlaceAPI).urlRequest
            NetworkRouter().fetch(request) { data, error in
                if let error = error {
                    print(error)
                }
                if let data = data,
                   let decodedData = try? JSONDecoder().decode(ParkingPlaceDTO.self, from: data) {
                    print(decodedData)
                }
            }
        } catch {
            print(error)
        }
    }
}
