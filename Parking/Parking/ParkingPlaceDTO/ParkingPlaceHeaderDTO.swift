//
//  ParkingPlaceHeaderDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceHeaderDTO: Decodable {
    let code: String
    let message: String
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
        type = try? container.decode(String.self, forKey: .type)
        try checkErrorCode()
    }

    private func checkErrorCode() throws {
        guard code != "00" else {
            return
        }

        switch code {
        case "1":
            throw ParkingPlaceAPIError.application(message)
        case "4":
            throw ParkingPlaceAPIError.http(message)
        case "10":
            throw ParkingPlaceAPIError.invalidRequestParameter(message)
        case "12":
            throw ParkingPlaceAPIError.nonexistent(message)
        case "20":
            throw ParkingPlaceAPIError.denied(message)
        case "22":
            throw ParkingPlaceAPIError.exceededRequest(message)
        case "30":
            throw ParkingPlaceAPIError.invalidApiKey(message)
        case "31":
            throw ParkingPlaceAPIError.expired(message)
        default:
            throw ParkingPlaceAPIError.unknown(message)
        }
    }
}
