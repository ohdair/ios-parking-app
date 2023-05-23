//
//  NaverGeocodingDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/23.
//

import Foundation

struct NaverGeocodingDTO {
    let status: String
    let meta: NaverGeocodingMetaDTO?
    let addresses: [NaverGeocodingAddressDTO]?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case status
        case meta
        case addresses
        case errorMessage
    }
}

extension NaverGeocodingDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        meta = try container.decode(NaverGeocodingMetaDTO?.self, forKey: .meta)
        addresses = try container.decode([NaverGeocodingAddressDTO]?.self, forKey: .addresses)
        errorMessage = try container.decode(String?.self, forKey: .errorMessage)
    }
}
