//
//  NetworkRouter.swift
//  Parking
//
//  Created by 박재우 on 2023/05/20.
//

import Foundation

class NetworkRouter {
    private var task: URLSessionDataTask?
    private let session = URLSession.shared

    func fetch(_ request: URLRequest, complition: @escaping (Data?, NetworkError?) -> Void) {
        task?.cancel()

        task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(nil, NetworkError.transportError(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) == false {
                complition(nil, NetworkError.responseError(statusCode: httpResponse.statusCode))
                return
            }

            guard let data = data else {
                complition(nil, NetworkError.invalidData)
                return
            }

            complition(data, nil)
        }

        task?.resume()
    }

    func fetchItem<T: Decodable>(with request: URLRequest, complition: @escaping (T?, NetworkError?) -> Void) {
        let decoder = JSONDecoder()

        fetch(request) { data, error in
            if let error = error {
                complition(nil, error)
            }

            guard let data = data,
                  let decodedData = try? decoder.decode(T.self, from: data) else {
                complition(nil, NetworkError.invalidData)
                return
            }

            complition(decodedData, nil)
        }
    }

}
