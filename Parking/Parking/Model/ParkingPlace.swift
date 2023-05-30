//
//  ParkingPlace.swift
//  Parking
//
//  Created by 박재우 on 2023/05/28.
//

import Foundation

extension ParkingPlace {
    func interpolate() {
        guard self.latitude.isZero,
              self.longitude.isZero else {
            return
        }

        let jibunAddress = self.jibunAddress ?? ""
        let roadAddress = self.roadAddress ?? ""
        let address = jibunAddress.isEmpty ? roadAddress : jibunAddress
        let endpoint = NaverGeocodingAPI(from: address)

        do {
            NetworkRouter().fetchItem(with: try endpoint.urlRequest, model: NaverGeocodingDTO.self) { data, error in
                if let error = error {
                    print(error)
                    return
                }

                if let data = data {
                    let convertedData = data.convert()
                    self.roadAddress = convertedData.roadAddress
                    self.latitude = convertedData.coordinate.latitude
                    self.longitude = convertedData.coordinate.longitude
                }
            }
        } catch {
            print(error)
        }
    }
}
