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
            let bundle = Bundle(for: type(of: self))
            guard let filePath = bundle.path(forResource: "전국주차장정보표준데이터", ofType: "json"),
                  let data = try String(contentsOfFile: filePath).data(using: .utf8) else {
                return
            }

            let decodedData = try JSONDecoder().decode(ParkingPlaceDTO.self, from: data)
            let items = decodedData.convert()


        } catch {
            print(error)
        }
    }
}
