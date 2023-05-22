//
//  APICallable.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import Foundation

protocol APICallable {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [String: String]? { get set }
    var httpHeaders: [String: String]? { get set }
    var httpMethod: HTTPMethod { get }
    var convertType: Convertable.Type { get }
}

protocol Convertable: Decodable {}
