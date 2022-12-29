//
//  UserViewAdapter.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserViewAdapter {
    weak var controller: UserListViewController?
    
    private let userLoader: UserLoader
    private let userSelection: (User) -> Void
    
    init(userLoader: UserLoader, userSelection: @escaping (User) -> Void) {
        self.userLoader = userLoader
        self.userSelection = userSelection
    }
    
    func loadUsers() {
        controller?.didStartLoading(isLoading: true)

        userLoader.loadUsers { [controller, userSelection] result in
            switch result {
            case let .success(users):
                let userItems = users.map { user in
                    UserItem(
                        name: user.firstName + " " + user.lastName,
                        email: user.email,
                        selection: {
                            userSelection(user)
                        }
                    )
                }
                controller?.didStartLoading(isLoading: false)
                controller?.didFinishLoading(users: userItems)
            case let .failure(error):
                controller?.didStartLoading(isLoading: false)
                controller?.didFinishLoading(with: error.localizedDescription)
            }
        }
    }
}

