//
//  UserFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

final class UserFactory {
    private init() {}
    
    static func makeUserListViewController(
        loader: UserLoader,
        selection: @escaping (User) -> Void
    ) -> UIViewController {
        let mainQueueLoader = MainQueueDispatchDecorator(decoratee: loader)
        let adapter = UserViewAdapter(
            userLoader: mainQueueLoader,
            userSelection: selection
        )
        let controller = UserListViewController(onDataLoadRequest: adapter.loadUsers)
        adapter.controller = controller
        controller.title = "User List"
        
        return controller
    }
}
