//
//  ParkingPlace.swift
//  Parking
//
//  Created by 박재우 on 2023/05/24.
//

import Foundation

struct ParkingPlace {
    var items: [ParkingPlaceItem]

    //MARK: - API 요청이 너무 많아 테스트를 위한 100개만 확인
    func interpolate() {
        //        items.forEach { parkplace in
        for index in 0...100 {
            DispatchQueue.global().async {

                var parkplace = items[index]

                guard parkplace.coordinate.latitude.isZero,
                      parkplace.coordinate.longitude.isZero else {
                    return
                }

                let address = parkplace.jibunAddress.isEmpty ? parkplace.roadAddress : parkplace.jibunAddress
                let endpoint = NaverGeocodingAPI(from: address)

                do {
                    NetworkRouter().fetchItem(with: try endpoint.urlRequest, model: NaverGeocodingDTO.self) { data, error in
                        if let error = error {
                            print(error)
                            return
                        }

                        if let data = data {
                            //                        print(index, data)
                            let convertedData = data.convert()
                            //                        print(index, convertedData)
                            parkplace.roadAddress = convertedData.roadAddress
                            parkplace.coordinate = convertedData.coordinate
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
