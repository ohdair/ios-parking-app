//
//  GeoCode.swift
//  Parking
//
//  Created by 박재우 on 2023/05/24.
//

import Foundation

struct GeoCode: Decodable {
    let coordinate: Coordinate
    let roadAddress: String
}
