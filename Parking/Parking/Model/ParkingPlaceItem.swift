//
//  ParkingPlaceItem.swift
//  Parking
//
//  Created by 박재우 on 2023/05/22.
//

import Foundation

struct ParkingPlaceItem {
    let number: UInt
    let name: String
    var roadAddress: String
    let jibunAddress: String
    let operatingDay: OperatingDay
    let operatingTime: OperatingTime
    let charge: ParkingPlaceCharge
    var coordinate: Coordinate
}
