//
//  ParkingPlaceAPI.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import Foundation

struct ParkingPlaceAPI: APICallable {

    let baseURL = "http://api.data.go.kr"
    let path = "/openapi/tn_pubr_prkplce_info_api"
    var httpHeaders: [String : String]?
    let httpMethod: HTTPMethod = .get
    var queryItems: [String : String]? = ["pageNo": "1", "numOfRows": "100", "type": "json"]
}
