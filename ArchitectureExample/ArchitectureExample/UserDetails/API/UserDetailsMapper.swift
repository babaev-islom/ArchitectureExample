//
//  UserDetailsMapper.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserDetailsMapper {
    private init() {}
        
    private struct APIUserDetails: Decodable {
        let id: String
        let age: Int
        let address: String
        let job: String
    }
    
    private static var OK_200: Int { 200 }
    
    enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> UserDetails {
        guard response.statusCode == OK_200, let user = try? JSONDecoder().decode(APIUserDetails.self, from: data) else {
            throw Error.invalidData
        }
        return UserDetails(id: user.id, age: user.age, address: user.address, occupation: user.job)
    }
}
