//
//  ParkingPlaceAPIError.swift
//  Parking
//
//  Created by 박재우 on 2023/05/22.
//

import Foundation

enum ParkingPlaceAPIError: LocalizedError {
    case application(_ message: String)
    case http(_ message: String)
    case invalidRequestParameter(_ message: String)
    case nonexistent(_ message: String)
    case denied(_ message: String)
    case exceededRequest(_ message: String)
    case invalidApiKey(_ message: String)
    case expired(_ message: String)
    case unknown(_ message: String)

    var errorDescription: String? {
        switch self {
        case .application(let message):
            return message
        case .http(let message):
            return message
        case .invalidRequestParameter(let message):
            return message
        case .nonexistent(let message):
            return message
        case .denied(let message):
            return message
        case .exceededRequest(let message):
            return message
        case .invalidApiKey(let message):
            return message
        case .expired(let message):
            return message
        case .unknown(let message):
            return message
        }
    }
}
