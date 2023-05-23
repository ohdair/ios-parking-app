//
//  ParkingPlace.swift
//  Parking
//
//  Created by 박재우 on 2023/05/22.
//

import Foundation

struct ParkingPlace {
    let name: String
    let roadNameAddress: String
    let lotNameAddress: String
    let operatingDay: OperatingDay
    let operatingTime: OperatingTime
    let charge: ParkingPlaceCharge
    let coordinate: Coordinate
}
