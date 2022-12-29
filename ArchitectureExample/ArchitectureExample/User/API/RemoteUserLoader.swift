//
//  RemoteUserLoader.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class RemoteUserLoader: UserLoader {
    private let url: URL
    private let client: APIClient
    
    init(url: URL, client: APIClient) {
        self.url = url
        self.client = client
    }
    
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let request = URLRequest(url: url)
        client.send(request) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let users = try UserMapper.map(data, from: response)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
