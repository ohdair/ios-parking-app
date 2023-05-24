//
//  ParkingPlaceBodyDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

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
    func convert() -> [ParkingPlace]? {

        let parkingPlaces = records.map { record in
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
            return ParkingPlace(number: number,
                                name: record.parkingPlaceName,
                                roadNameAddress: record.roadAddress,
                                lotNameAddress: record.jibunAddress,
                                operatingDay: operatingDay,
                                operatingTime: operatingTime,
                                charge: charge,
                                coordinate: coordinate)
        }

        return parkingPlaces
    }
}
