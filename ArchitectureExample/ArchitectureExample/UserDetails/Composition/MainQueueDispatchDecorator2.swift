//
//  MainQueueDispatchDecorator2.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class MainQueueDispatchDecorator2: UserDetailsLoader {
    private let decoratee: UserDetailsLoader
    
    init(decoratee: UserDetailsLoader) {
        self.decoratee = decoratee
    }
    
    func loadUserDetails(by id: String, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        decoratee.loadUserDetails(by: id) { result in
            if Thread.isMainThread {
                completion(result)
            } else {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
