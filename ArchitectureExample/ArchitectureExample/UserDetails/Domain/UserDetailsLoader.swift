//
//  UserDetailsLoader.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

protocol UserDetailsLoader {
    func loadUserDetails(by id: String, completion: @escaping (Result<UserDetails, Error>) -> Void)
}
