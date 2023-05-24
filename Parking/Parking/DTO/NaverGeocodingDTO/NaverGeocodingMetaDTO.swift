//
//  NaverGeocodingMetaDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/23.
//

import Foundation

struct NaverGeocodingMetaDTO: Decodable {
    let totalCount: Int?
    let page: Int?
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case totalCount
        case page
        case count
    }
}

extension NaverGeocodingMetaDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try container.decode(Int?.self, forKey: .totalCount)
        page = try container.decode(Int?.self, forKey: .page)
        count = try container.decode(Int?.self, forKey: .count)
    }
}
