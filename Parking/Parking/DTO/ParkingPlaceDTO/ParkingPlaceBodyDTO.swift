//
//  ParkingPlaceBodyDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation
import CoreData

struct ParkingPlaceDTO: Decodable {
    let fields: [ParkingPlaceFieldDTO]
    let records: [ParkingPlaceItemDTO]

    enum CodingKeys: String, CodingKey {
        case fields
        case records
    }
}

extension ParkingPlaceDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decode([ParkingPlaceItemDTO].self, forKey: .records)
        fields = try container.decode([ParkingPlaceFieldDTO].self, forKey: .fields)
    }
}

extension ParkingPlaceDTO {
    func createParkingPlaceContext(context: NSManagedObjectContext) {
        records.forEach { record in
            guard let number = Int64(record.parkingPlaceNumber.components(separatedBy: "-").joined()) else {
                return
            }
            let operatingDays = record.operatingDays.components(separatedBy: "+")
            let chargeType: ChargeType = record.parkingPlaceType == "무료" ? .free : .paid
            let baseTime = Int16(record.basicTime) ?? 0
            let baseAmount = Int16(record.basicCharge) ?? 0
            let additionalTime = Int16(record.additionalUnitTime) ?? 0
            let additionalAmount = Int16(record.additionalUnitCharge) ?? 0

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

            newParkingPlace.interpolate()

            do {
                try context.save()
            } catch {
                print("Failed to save test data: \(error)")
            }
        }
    }

    func convert() -> ParkingPlaces {
        let parkingPlaceItems = records.map { record in
            let number = UInt(record.parkingPlaceNumber.components(separatedBy: "-").joined()) ?? 0
            let weekDayTimeTable = TimeTable(open: record.weekdayOperationOpenTime,
                                             close: record.weekdayOperationCloseTime)
            let saturDayTimeTable = TimeTable(open: record.saturdayOperationOpenTime,
                                              close: record.saturdayOperationCloseTime)
            let holidayTimeTable = TimeTable(open: record.holidayOperationOpenTime,
                                             close: record.holidayOperationCloseTime)
            let operatingDayData = record.operatingDays.components(separatedBy: "+")
            let operatingDay = OperatingDay(weekday: operatingDayData.contains("평일"),
                                            saturday: operatingDayData.contains("토요일"),
                                            holiday: operatingDayData.contains("공휴일"))
            let operatingTime = OperatingTime(weekday: weekDayTimeTable,
                                              saturday: saturDayTimeTable,
                                              holiday: holidayTimeTable)
            let chargeType: ChargeType = record.parkingchargeInformation == "무료" ? .free : .paid
            let baseCharge = ChargeInformation(time: UInt(record.basicTime) ?? 0,
                                               amount: UInt(record.basicCharge) ?? 0)
            let additionalCharge = ChargeInformation(time: UInt(record.additionalUnitTime) ?? 0,
                                                     amount: UInt(record.additionalUnitCharge) ?? 0)
            let charge = ParkingPlaceCharge(type: chargeType,
                                            base: baseCharge,
                                            additional: additionalCharge)
            let coordinate = Coordinate(latitude: Double(record.latitude) ?? 0,
                                        longitude: Double(record.longitude) ?? 0)
            return ParkingPlaceItem(number: number,
                                    name: record.parkingPlaceName,
                                    roadAddress: record.roadAddress,
                                    jibunAddress: record.jibunAddress,
                                    operatingDay: operatingDay,
                                    operatingTime: operatingTime,
                                    charge: charge,
                                    coordinate: coordinate)
        }

        return ParkingPlaces(items: parkingPlaceItems)
    }
}
