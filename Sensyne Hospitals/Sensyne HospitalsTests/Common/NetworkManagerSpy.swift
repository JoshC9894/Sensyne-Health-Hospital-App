//
//  NetworkManagerSpy.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//

import Foundation
@testable import Sensyne_Hospitals

class NetworkManagerSpy: NetworkManagerProtocol {
    var didCallRequest: Bool = false
    var responseData: Data?
    
    func request(url: String, type: NetworkManager.RequestType, completion: @escaping Callback<Data?>) {
        self.didCallRequest = true
        guard let data = self.responseData else {
            let error = NetworkError(message: "Network error")
            completion(Result.failure(error))
            return
        }
        completion(Result.success(data))
    }
}
