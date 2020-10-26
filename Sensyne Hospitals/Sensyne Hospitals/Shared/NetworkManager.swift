//
//  NetworkManager.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import Foundation

typealias Callback<T> = (Result<T, Error>) -> Void

// MARK: - Network Error
struct NetworkError: Error {
    var message: String
}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func request(url: String, type: NetworkManager.RequestType, completion: @escaping Callback<Data?>)
}

// MARK: - NetworkManager
class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    enum RequestType: String {
        case get = "GET"
    }
    
    // MARK: - NetworkManagerProtocol Methods
    func request(url: String, type: RequestType, completion: @escaping Callback<Data?>) {
        guard let url = URL(string: url) else {
            let error = NetworkError(message: "Invalid url")
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        executeTask(request: request, completion: completion)
    }
    
    fileprivate func executeTask(request: URLRequest, completion: @escaping Callback<Data?>) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            completion(Result.success(data))
        }
        task.resume()
    }
}
