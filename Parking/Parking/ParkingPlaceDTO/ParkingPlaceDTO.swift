//
//  ParkingPlaceDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceDTO: Decodable, Convertable {
    let result: ParkingPlaceResultDTO

    enum CodingKeys: String, CodingKey {
        case result = "response"
    }
}

extension ParkingPlaceDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(ParkingPlaceResultDTO.self, forKey: .result)
    }
}
