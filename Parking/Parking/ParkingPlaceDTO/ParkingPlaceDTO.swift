//
//  ParkingPlaceDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceDTO: Decodable {
    let result: ParkingPlaceResultDTO

    enum CodingKeys: String, CodingKey {
        case result = "response"
    }
}
