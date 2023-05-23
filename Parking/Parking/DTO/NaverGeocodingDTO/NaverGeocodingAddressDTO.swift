//
//  NaverGeocodingAddressDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/23.
//

import Foundation

struct NaverGeocodingAddressDTO: Decodable {
    let roadAddress: String?
    let jibunAddress: String?
    let englishAddress: String?
    let addressElements: [NaverGeocodingAddressElementDTO]?
    let longitude: String?
    let latitude: String?
    let distance: String?

    enum CodingKeys: String, CodingKey {
        case roadAddress
        case jibunAddress
        case englishAddress
        case addressElements
        case longitude = "x"
        case latitude = "y"
        case distance
    }
}

extension NaverGeocodingAddressDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        roadAddress = try container.decode(String?.self, forKey: .roadAddress)
        jibunAddress = try container.decode(String?.self, forKey: .jibunAddress)
        englishAddress = try container.decode(String?.self, forKey: .englishAddress)
        addressElements = try container.decode([NaverGeocodingAddressElementDTO]?.self, forKey: .addressElements)
        longitude = try container.decode(String?.self, forKey: .longitude)
        latitude = try container.decode(String?.self, forKey: .latitude)
        distance = try container.decode(String?.self, forKey: .distance)
    }
}
