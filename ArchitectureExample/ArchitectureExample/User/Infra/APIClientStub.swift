//
//  APIClientStub.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class APIClientStub: APIClient {
    func send(_ request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        
        let user1: [String: Any] = [
            "id": "unique id 1",
            "first_name": "unique first name 1",
            "last_name": "unique last name 1",
            "email": "unique_email 1"
        ]
        
        let user2: [String: Any] = [
            "id": "unique id 2",
            "first_name": "unique first name 2",
            "last_name": "unique last name 2",
            "email": "unique_email 2"
        ]

        let json = [
            "users": [user1, user2]
        ]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        DispatchQueue.global().async {
            completion(.success((data, response)))
        }
    }
}
