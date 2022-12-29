//
//  MainQueueDispatchDecorator.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class MainQueueDispatchDecorator: UserLoader {
    private let decoratee: UserLoader
    
    init(decoratee: UserLoader) {
        self.decoratee = decoratee
    }
    
    func loadUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        decoratee.loadUsers { result in
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
