//
//  EndPoint.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import Foundation

struct EndPoint {

    private var endpoint: APICallable

    init(_ endpoint: APICallable) {
        self.endpoint = endpoint
    }

    var url: URL {
        get throws {
            let urlString = "\(endpoint.baseURL)\(endpoint.path)"

            guard var componentURL = URLComponents(string: urlString) else {
                throw NetworkError.invalidURL
            }

            componentURL.queryItems = queryItems
            componentURL.percentEncodedQuery = componentURL.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

            guard let url = componentURL.url else {
                throw NetworkError.invalidURL
            }

            return url
        }
    }

    var urlRequest: URLRequest {
        get throws {
            var request = URLRequest(url: try url)

            request.httpMethod = endpoint.httpMethod.rawValue
            request.allHTTPHeaderFields = endpoint.httpHeaders

            return request
        }
    }

    private var queryItems: [URLQueryItem]? {
        endpoint.queryItems?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}