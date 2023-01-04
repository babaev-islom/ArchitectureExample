//
//  UserFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit
import Combine

final class UserFactory {
    private init() {}
    
    static func makeUserListViewController(
        loader: @escaping () -> AnyPublisher<[User], Error>,
        selection: @escaping (User) -> Void
    ) -> UIViewController {
//        let mainQueueLoader = MainQueueDispatchDecorator(decoratee: loader)
        let adapter = UserViewAdapter(
            userLoader: { loader().receive(on: DispatchQueue.main).eraseToAnyPublisher() },
            userSelection: selection
        )
        let controller = UserListViewController(onDataLoadRequest: adapter.loadUsers)
        adapter.controller = controller
        controller.title = "User List"
        
        return controller
    }
}
