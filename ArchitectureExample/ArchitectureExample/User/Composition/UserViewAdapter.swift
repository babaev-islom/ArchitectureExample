//
//  UserViewAdapter.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation
import Combine

final class UserViewAdapter {
    weak var controller: UserListViewController?
    
    private let userLoader: () -> AnyPublisher<[User], Error>
    private let userSelection: (User) -> Void
    
    private var cancellable: AnyCancellable?
    
    init(userLoader: @escaping () -> AnyPublisher<[User], Error>, userSelection: @escaping (User) -> Void) {
        self.userLoader = userLoader
        self.userSelection = userSelection
    }
    
    func loadUsers() {
        controller?.didStartLoading(isLoading: true)

        cancellable = userLoader()
            .sink { [controller] result in
                switch result {
                case let .failure(error):
                    controller?.didStartLoading(isLoading: false)
                    controller?.didFinishLoading(with: error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: {  [controller, userSelection] users in
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
            }
    }
}

