//
//  ParkingPlaceBodyDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation
import CoreData

struct ParkingPlaceBodyDTO: Decodable {
    let fields: [ParkingPlaceFieldDTO]
    let records: [ParkingPlaceItemDTO]

    enum CodingKeys: String, CodingKey {
        case fields
        case records
    }
}

extension ParkingPlaceBodyDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decode([ParkingPlaceItemDTO].self, forKey: .records)
        fields = try container.decode([ParkingPlaceFieldDTO].self, forKey: .fields)
    }
}

extension ParkingPlaceBodyDTO {
    func createParkingPlaceContext(context: NSManagedObjectContext) async {
        records.forEach { record in
            guard let number = Int64(record.parkingPlaceNumber.components(separatedBy: "-").joined()) else {
                return
            }
            let operatingDays = record.operatingDays.components(separatedBy: "+")
            let chargeType: ChargeType = record.parkingchargeInformation == "무료" ? .free : .paid
            let baseTime = Int64(record.basicTime) ?? 0
            let baseAmount = Int64(record.basicCharge) ?? 0
            let additionalTime = Int64(record.additionalUnitTime) ?? 0
            let additionalAmount = Int64(record.additionalUnitCharge) ?? 0

            let newParkingPlace = ParkingPlace(context: context)
            newParkingPlace.number = number
            newParkingPlace.name = record.parkingPlaceName
            newParkingPlace.roadAddress = record.roadAddress
            newParkingPlace.jibunAddress = record.jibunAddress
            newParkingPlace.weekdayOperating = operatingDays.contains("평일")
            newParkingPlace.saturdayOperating = operatingDays.contains("토요일")
            newParkingPlace.holidayOperating = operatingDays.contains("공휴일")
            newParkingPlace.weekdayOpenTime = record.weekdayOperationOpenTime
            newParkingPlace.weekdayCloseTime = record.weekdayOperationCloseTime
            newParkingPlace.saturdayOpenTime = record.saturdayOperationOpenTime
            newParkingPlace.saturdayCloseTime = record.saturdayOperationCloseTime
            newParkingPlace.holidayOpenTime = record.holidayOperationOpenTime
            newParkingPlace.holidayCloseTime = record.holidayOperationCloseTime
            newParkingPlace.chargeType = Int16(chargeType.rawValue)
            newParkingPlace.baseChargeTime = baseTime
            newParkingPlace.baseChargeAmount = baseAmount
            newParkingPlace.additionalChargeTime = additionalTime
            newParkingPlace.additionalChargeAmount = additionalAmount
            newParkingPlace.latitude = Double(record.latitude) ?? 0
            newParkingPlace.longitude = Double(record.longitude) ?? 0
            newParkingPlace.contactNumber = record.phoneNumber

            newParkingPlace.interpolate()
        }
    }
}


