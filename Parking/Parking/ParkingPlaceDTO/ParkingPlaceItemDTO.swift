//
//  ParkingPlaceItemDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceItemDTO: Decodable {
    let parkingPlaceNumber: String
    let parkingPlaceName: String
    let parkingPlaceCategory: String
    let parkingPlaceType: String
    let roadNameAddress: String
    let lotNameAddress: String
    let parkingCompartments: String
    let feedCategory: String
    let enforceCategory: String
    let operatingDays: String
    let weekdayOperationOpenTime: String
    let weekdayOperationCloseTime: String
    let saturdayOperationOpenTime: String
    let saturdayOperationCloseTime: String
    let holidayOperationOpenTime: String
    let holidayOperationCloseTime: String
    let parkingchargeInformation: String
    let basicTime: String
    let basicCharge: String
    let additionalUnitTime: String
    let additionalUnitCharge: String
    let dayCommonTicketAdjustmentTime: String
    let dayCommonTicketCharge: String
    let monthCommonTicketCharge: String
    let payments: String
    let specialNotes: String
    let institutionName: String
    let phoneNumber: String
    let latitude: String
    let longitude: String
    let referenceDate: String
    let insttCode: String

    enum CodingKeys: String, CodingKey {
        case parkingPlaceNumber = "prkplceNo"
        case parkingPlaceName = "prkplceNm"
        case parkingPlaceCategory = "prkplceSe"
        case parkingPlaceType = "prkplceType"
        case roadNameAddress = "rdnmadr"
        case lotNameAddress = "lnmadr"
        case parkingCompartments = "prkcmprt"
        case feedCategory = "feedingSe"
        case enforceCategory = "enforceSe"
        case operatingDays = "operDay"
        case weekdayOperationOpenTime = "weekdayOperOpenHhmm"
        case weekdayOperationCloseTime = "weekdayOperColseHhmm"
        case saturdayOperationOpenTime = "satOperOperOpenHhmm"
        case saturdayOperationCloseTime = "satOperCloseHhmm"
        case holidayOperationOpenTime = "holidayOperOpenHhmm"
        case holidayOperationCloseTime = "holidayCloseOpenHhmm"
        case parkingchargeInformation = "parkingchrgeInfo"
        case basicTime
        case basicCharge
        case additionalUnitTime = "addUnitTime"
        case additionalUnitCharge = "addUnitCharge"
        case dayCommonTicketAdjustmentTime = "dayCmmtktAdjTime"
        case dayCommonTicketCharge = "dayCmmtkt"
        case monthCommonTicketCharge = "monthCmmtkt"
        case payments = "metpay"
        case specialNotes = "spcmnt"
        case institutionName = "institutionNm"
        case phoneNumber
        case latitude
        case longitude
        case referenceDate
        case insttCode
    }
}

extension ParkingPlaceItemDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parkingPlaceNumber = try container.decode(String.self, forKey: .parkingPlaceNumber)
        parkingPlaceName = try container.decode(String.self, forKey: .parkingPlaceName)
        parkingPlaceCategory = try container.decode(String.self, forKey: .parkingPlaceCategory)
        parkingPlaceType = try container.decode(String.self, forKey: .parkingPlaceType)
        roadNameAddress = try container.decode(String.self, forKey: .roadNameAddress)
        lotNameAddress = try container.decode(String.self, forKey: .lotNameAddress)
        parkingCompartments = try container.decode(String.self, forKey: .parkingCompartments)
        feedCategory = try container.decode(String.self, forKey: .feedCategory)
        enforceCategory = try container.decode(String.self, forKey: .enforceCategory)
        operatingDays = try container.decode(String.self, forKey: .operatingDays)
        weekdayOperationOpenTime = try container.decode(String.self, forKey: .weekdayOperationOpenTime)
        weekdayOperationCloseTime = try container.decode(String.self, forKey: .weekdayOperationCloseTime)
        saturdayOperationOpenTime = try container.decode(String.self, forKey: .saturdayOperationOpenTime)
        saturdayOperationCloseTime = try container.decode(String.self, forKey: .saturdayOperationCloseTime)
        holidayOperationOpenTime = try container.decode(String.self, forKey: .holidayOperationOpenTime)
        holidayOperationCloseTime = try container.decode(String.self, forKey: .holidayOperationCloseTime)
        parkingchargeInformation = try container.decode(String.self, forKey: .parkingchargeInformation)
        basicTime = try container.decode(String.self, forKey: .basicTime)
        basicCharge = try container.decode(String.self, forKey: .basicCharge)
        additionalUnitTime = try container.decode(String.self, forKey: .additionalUnitTime)
        additionalUnitCharge = try container.decode(String.self, forKey: .additionalUnitCharge)
        dayCommonTicketAdjustmentTime = try container.decode(String.self, forKey: .dayCommonTicketAdjustmentTime)
        dayCommonTicketCharge = try container.decode(String.self, forKey: .dayCommonTicketCharge)
        monthCommonTicketCharge = try container.decode(String.self, forKey: .monthCommonTicketCharge)
        payments = try container.decode(String.self, forKey: .payments)
        specialNotes = try container.decode(String.self, forKey: .specialNotes)
        institutionName = try container.decode(String.self, forKey: .institutionName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        referenceDate = try container.decode(String.self, forKey: .referenceDate)
        insttCode = try container.decode(String.self, forKey: .insttCode)
    }
}
