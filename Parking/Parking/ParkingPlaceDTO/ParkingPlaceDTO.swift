//
//  ParkingPlaceDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceDTO: Decodable, Convertable {
    let result: ParkingPlaceResultDTO

    enum CodingKeys: String, CodingKey {
        case result = "response"
    }
}

extension ParkingPlaceDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(ParkingPlaceResultDTO.self, forKey: .result)
    }
}

extension ParkingPlaceDTO {
    func convert() -> [ParkingPlace]? {
        guard let items = result.body?.items else {
            return nil
        }

        let parkingPlaces = items.map { parkingPlace in
            let weekDayTimeTable = TimeTable(open: parkingPlace.weekdayOperationOpenTime,
                                             close: parkingPlace.weekdayOperationCloseTime)
            let saturDayTimeTable = TimeTable(open: parkingPlace.saturdayOperationOpenTime,
                                              close: parkingPlace.saturdayOperationCloseTime)
            let holidayTimeTable = TimeTable(open: parkingPlace.holidayOperationOpenTime,
                                             close: parkingPlace.holidayOperationCloseTime)
            let operatingDayData = parkingPlace.operatingDays.components(separatedBy: "+")
            let operatingDay = OperatingDay(weekday: operatingDayData.contains("평일"),
                                            saturday: operatingDayData.contains("토요일"),
                                            holiday: operatingDayData.contains("공휴일"))
            let operatingTime = OperatingTime(weekday: weekDayTimeTable,
                                              saturday: saturDayTimeTable,
                                              holiday: holidayTimeTable)
            let chargeType: ChargeType = parkingPlace.parkingchargeInformation == "무료" ? .free : .paid
            let baseCharge = ChargeInformation(time: UInt(parkingPlace.basicTime) ?? 0,
                                               amount: UInt(parkingPlace.basicCharge) ?? 0)
            let additionalCharge = ChargeInformation(time: UInt(parkingPlace.additionalUnitTime) ?? 0,
                                                     amount: UInt(parkingPlace.additionalUnitCharge) ?? 0)
            let charge = ParkingPlaceCharge(type: chargeType,
                                            base: baseCharge,
                                            additional: additionalCharge)
            let coordinate = Coordinate(latitude: Float(parkingPlace.latitude) ?? 0,
                                        longitude: Float(parkingPlace.longitude) ?? 0)
            return ParkingPlace(name: parkingPlace.parkingPlaceName,
                                roadNameAddress: parkingPlace.roadNameAddress,
                                lotNameAddress: parkingPlace.lotNameAddress,
                                operatingDay: operatingDay,
                                operatingTime: operatingTime,
                                charge: charge,
                                coordinate: coordinate)
        }

        return parkingPlaces
    }
}
