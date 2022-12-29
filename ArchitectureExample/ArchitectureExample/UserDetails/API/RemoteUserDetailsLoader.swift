//
//  RemoteUserDetailsLoader.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class RemoteUserDetailsLoader: UserDetailsLoader {
    private let url: URL
    private let client: APIClient2
    
    init(url: URL, client: APIClient2) {
        self.url = url
        self.client = client
    }
    
    func loadUserDetails(by id: String, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        // add id as a query
        let request = URLRequest(url: url)
        client.send(request) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let details = try UserDetailsMapper.map(data, from: response)
                    completion(.success(details))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }

    }
}
