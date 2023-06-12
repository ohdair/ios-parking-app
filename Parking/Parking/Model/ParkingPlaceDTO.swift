//
//  ParkingPlaceDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/06/12.
//

import Foundation
import CoreData

struct ParkingPlaceDTO: Codable {
    let additionalChargeTime: Int
    let saturdayCloseTime: String
    let holidayCloseTime: String
    let holidayOpenTime: String
    let weekdayOpenTime: String
    let latitude: Double
    let baseChargeAmount: Int
    let weekdayOperating: Bool
    let contactNumber: String
    let name: String
    let additionalChargeAmount: Int
    let number: Int
    let longitude: Double
    let weekdayCloseTime: String
    let jibunAddress: String
    let roadAddress: String
    let baseChargeTime: Int
    let chargeType: Int
    let saturdayOpenTime: String
    let saturdayOperating: Bool
    let holidayOperating: Bool

    enum CodingKeys: String, CodingKey {
        case additionalChargeTime
        case saturdayCloseTime
        case holidayCloseTime
        case holidayOpenTime
        case weekdayOpenTime
        case latitude
        case baseChargeAmount
        case weekdayOperating
        case contactNumber
        case name
        case additionalChargeAmount
        case number
        case longitude
        case weekdayCloseTime
        case jibunAddress
        case roadAddress
        case baseChargeTime
        case chargeType
        case saturdayOpenTime
        case saturdayOperating
        case holidayOperating
    }
}

extension ParkingPlaceDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        additionalChargeTime = try container.decode(Int.self, forKey: .additionalChargeTime)
        saturdayCloseTime = try container.decode(String.self, forKey: .saturdayCloseTime)
        holidayCloseTime = try container.decode(String.self, forKey: .holidayCloseTime)
        holidayOpenTime = try container.decode(String.self, forKey: .holidayOpenTime)
        weekdayOpenTime = try container.decode(String.self, forKey: .weekdayOpenTime)
        latitude = try container.decode(Double.self, forKey: .latitude)
        baseChargeAmount = try container.decode(Int.self, forKey: .baseChargeAmount)
        weekdayOperating = try container.decode(Bool.self, forKey: .weekdayOperating)
        contactNumber = try container.decode(String.self, forKey: .contactNumber)
        name = try container.decode(String.self, forKey: .name)
        additionalChargeAmount = try container.decode(Int.self, forKey: .additionalChargeAmount)
        number = try container.decode(Int.self, forKey: .number)
        longitude = try container.decode(Double.self, forKey: .longitude)
        weekdayCloseTime = try container.decode(String.self, forKey: .weekdayCloseTime)
        jibunAddress = try container.decode(String.self, forKey: .jibunAddress)
        roadAddress = try container.decode(String.self, forKey: .roadAddress)
        baseChargeTime = try container.decode(Int.self, forKey: .baseChargeTime)
        chargeType = try container.decode(Int.self, forKey: .chargeType)
        saturdayOpenTime = try container.decode(String.self, forKey: .saturdayOpenTime)
        saturdayOperating = try container.decode(Bool.self, forKey: .saturdayOperating)
        holidayOperating = try container.decode(Bool.self, forKey: .holidayOperating)
    }
}

extension ParkingPlaceDTO {
    func createParkingPlaceContext(context: NSManagedObjectContext) {
        let number = Int64(self.number)
        let baseChargeTime = Int64(self.baseChargeTime)
        let baseChargeAmount = Int64(self.baseChargeAmount)
        let additionalChargeTime = Int64(self.additionalChargeTime)
        let additionalChargeAmount = Int64(self.additionalChargeAmount)
        let chargeType = Int16(self.chargeType)

        let newParkingPlace = ParkingPlace(context: context)
        newParkingPlace.name = name
        newParkingPlace.number = number
        newParkingPlace.baseChargeTime = baseChargeTime
        newParkingPlace.baseChargeAmount = baseChargeAmount
        newParkingPlace.additionalChargeTime = additionalChargeTime
        newParkingPlace.additionalChargeAmount = additionalChargeAmount
        newParkingPlace.chargeType = chargeType
        newParkingPlace.jibunAddress = jibunAddress
        newParkingPlace.roadAddress = roadAddress
        newParkingPlace.weekdayOperating = weekdayOperating
        newParkingPlace.saturdayOperating = saturdayOperating
        newParkingPlace.holidayOperating = holidayOperating
        newParkingPlace.weekdayOpenTime = weekdayOpenTime
        newParkingPlace.weekdayCloseTime = weekdayCloseTime
        newParkingPlace.saturdayOpenTime = saturdayOpenTime
        newParkingPlace.saturdayCloseTime = saturdayCloseTime
        newParkingPlace.holidayOpenTime = holidayOpenTime
        newParkingPlace.holidayCloseTime = holidayCloseTime
        newParkingPlace.latitude = latitude
        newParkingPlace.longitude = longitude
        newParkingPlace.contactNumber = contactNumber
    }
}
