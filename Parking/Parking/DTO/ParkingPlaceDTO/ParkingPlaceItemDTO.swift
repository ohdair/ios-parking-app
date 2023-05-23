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
    let roadAddress: String
    let jibunAddress: String
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
    let providerCode: String
    let providerName: String

    enum CodingKeys: String, CodingKey {
        case parkingPlaceNumber = "주차장관리번호"
        case parkingPlaceName = "주차장명"
        case parkingPlaceCategory = "주차장구분"
        case parkingPlaceType = "주차장유형"
        case roadAddress = "소재지도로명주소"
        case jibunAddress = "소재지지번주소"
        case parkingCompartments = "주차구획수"
        case feedCategory = "급지구분"
        case enforceCategory = "부제시행구분"
        case operatingDays = "운영요일"
        case weekdayOperationOpenTime = "평일운영시작시각"
        case weekdayOperationCloseTime = "평일운영종료시각"
        case saturdayOperationOpenTime = "토요일운영시작시각"
        case saturdayOperationCloseTime = "토요일운영종료시각"
        case holidayOperationOpenTime = "공휴일운영시작시각"
        case holidayOperationCloseTime = "공휴일운영종료시각"
        case parkingchargeInformation = "요금정보"
        case basicTime = "주차기본시간"
        case basicCharge = "주차기본요금"
        case additionalUnitTime = "추가단위시간"
        case additionalUnitCharge = "추가단위요금"
        case dayCommonTicketAdjustmentTime = "1일주차권요금적용시간"
        case dayCommonTicketCharge = "1일주차권요금"
        case monthCommonTicketCharge = "월정기권요금"
        case payments = "결제방법"
        case specialNotes = "특기사항"
        case institutionName = "관리기관명"
        case phoneNumber = "전화번호"
        case latitude = "위도"
        case longitude = "경도"
        case referenceDate = "데이터기준일자"
        case providerCode = "제공기관코드"
        case providerName = "제공기관명"
    }
}

extension ParkingPlaceItemDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        parkingPlaceNumber = try container.decode(String.self, forKey: .parkingPlaceNumber)
        parkingPlaceName = try container.decode(String.self, forKey: .parkingPlaceName)
        parkingPlaceCategory = try container.decode(String.self, forKey: .parkingPlaceCategory)
        parkingPlaceType = try container.decode(String.self, forKey: .parkingPlaceType)
        roadAddress = try container.decode(String.self, forKey: .roadAddress)
        jibunAddress = try container.decode(String.self, forKey: .jibunAddress)
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
        providerCode = try container.decode(String.self, forKey: .providerCode)
        providerName = try container.decode(String.self, forKey: .providerName)
    }
}
