//
//  Endpoint.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [String: String]? { get set }
    var httpHeaders: [String: String]? { get set }
    var httpMethod: HTTPMethod { get }
}

extension Endpoint {
    var url: URL {
        get throws {
            guard var componentURL = URLComponents(string: baseURL + path) else {
                throw NetworkError.invalidURL
            }

            componentURL.queryItems = queryItems

            guard let url = componentURL.url else {
                throw NetworkError.invalidURL
            }

            return url
        }
    }

    var urlRequest: URLRequest {
        get throws {
            var request = URLRequest(url: try url)

            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = httpHeaders

            return request
        }
    }

    private var queryItems: [URLQueryItem]? {
        self.queryItems?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}
