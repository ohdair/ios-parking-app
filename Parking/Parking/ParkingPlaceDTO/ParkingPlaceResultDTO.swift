//
//  ParkingPlaceResultDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceResultDTO: Decodable {
    let header: ParkingPlaceHeaderDTO
    let body: ParkingPlaceBodyDTO?

    enum CodingKeys: String, CodingKey {
        case header
        case body
    }
}

extension ParkingPlaceResultDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decode(ParkingPlaceHeaderDTO.self, forKey: .header)
        body = try container.decode(ParkingPlaceBodyDTO.self, forKey: .body)
    }
}
