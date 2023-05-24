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

    func fetchItem<T: Convertable>(with request: URLRequest, model: T.Type, complition: @escaping (T?, Error?) -> Void) {
        fetch(request) { data, error in
            do {
                if let error = error {
                    complition(nil, error)
                }

                if let data = data {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    complition(decodedData, nil)
                    return
                }

                complition(nil, NetworkError.invalidData)
            } catch {
                complition(nil, error)
            }
        }
    }

}
