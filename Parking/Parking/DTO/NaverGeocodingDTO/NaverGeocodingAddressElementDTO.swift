//
//  NaverGeocodingAddressElementDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/23.
//

import Foundation

struct NaverGeocodingAddressElementDTO: Decodable {
    let types: [String]?
    let longName: String?
    let shortName: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case types
        case longName
        case shortName
        case code
    }
}

extension NaverGeocodingAddressElementDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        types = try container.decode([String]?.self, forKey: .types)
        longName = try container.decode(String?.self, forKey: .longName)
        shortName = try container.decode(String?.self, forKey: .shortName)
        code = try container.decode(String?.self, forKey: .code)
    }
}
