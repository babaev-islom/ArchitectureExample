//
//  UserMapper.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserMapper {
    private init() {}
    
    private struct Root: Decodable {
        let users: [APIUser]
    }
    
    private struct APIUser: Decodable {
        let id: String
        let first_name: String
        let last_name: String
        let email: String
    }
    
    private static var OK_200: Int { 200 }
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [User] {
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.users.map { User(id: $0.id, firstName: $0.first_name, lastName: $0.last_name, email: $0.email) }
    }
}
