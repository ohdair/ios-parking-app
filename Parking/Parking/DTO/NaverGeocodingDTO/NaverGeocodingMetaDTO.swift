//
//  NaverGeocodingMetaDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/23.
//

import Foundation

struct NaverGeocodingMetaDTO: Decodable {
    let totalCount: String?
    let page: String?
    let count: String?

    enum CodingKeys: String, CodingKey {
        case totalCount
        case page
        case count
    }
}

extension NaverGeocodingMetaDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try container.decode(String?.self, forKey: .totalCount)
        page = try container.decode(String?.self, forKey: .page)
        count = try container.decode(String?.self, forKey: .count)
    }
}
