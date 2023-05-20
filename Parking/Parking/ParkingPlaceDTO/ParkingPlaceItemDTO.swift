//
//  ParkingPlaceItemDTO.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

struct ParkingPlaceItemDTO: Decodable {
    let parkingPlaceNumber: String?
    let parkingPlaceName: String?
    let parkingPlaceCategory: String?
    let parkingPlaceType: String?
    let roadNameAddress: String?
    let lotNameAddress: String?
    let parkingCompartments: String?
    let feedCategory: String?
    let enforceCategory: String?
    let operatingDays: String?
    let weekdayOperationOpenTime: String?
    let weekdayOperationCloseTime: String?
    let saturdayOperationOpenTime: String?
    let saturdayOperationCloseTime: String?
    let holidayOperationOpenTime: String?
    let holidayOperationCloseTime: String?
    let parkingchargeInformation: String?
    let basicTime: String?
    let basicCharge: String?
    let additionalUnitTime: String?
    let additionalUnitCharge: String?
    let dayCommonTicketAdjustmentTime: String?
    let dayCommonTicketCharge: String?
    let monthCommonTicketCharge: String?
    let payments: String?
    let specialNotes: String?
    let institutionName: String?
    let phoneNumber: String?
    let latitude: String?
    let longitude: String?
    let referenceDate: String?
    let insttCode: String?

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
