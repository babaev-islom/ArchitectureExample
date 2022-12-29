//
//  ApiClientStub2.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class APIClientStub2: APIClient2 {
    func send(_ request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        
        let userDetails: [String: Any] = [
            "id": "unique id 1",
            "age": 25,
            "address": "London, UK",
            "job": "any random job"
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: userDetails)
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        DispatchQueue.global().async {
            completion(.success((data, response)))
        }
    }
}
