//
//  ParkingPlaceHeaderDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceHeaderDTO: Decodable {
    let code: String?
    let message: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case code = "resultCode"
        case message = "resultMsg"
        case type
    }
}
