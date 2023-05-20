//
//  ParkingPlaceBodyDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceBodyDTO: Decodable {
    let items: [ParkingPlaceItemDTO]?
    let totalCount: String?
    let numOfRows: String?
    let pageNumber: String?

    enum CodingKeys: String, CodingKey {
        case items
        case totalCount
        case numOfRows
        case pageNumber = "pageNo"
    }
}
