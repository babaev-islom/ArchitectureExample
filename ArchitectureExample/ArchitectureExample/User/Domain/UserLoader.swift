//
//  UserLoader.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

protocol UserLoader {
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void)
}
