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

extension ParkingPlaceHeaderDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        type = try container.decode(String.self, forKey: .type)
    }
}
