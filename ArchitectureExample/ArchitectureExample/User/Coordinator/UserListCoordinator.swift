//
//  UserListCoordinator.swift
//  ArchitectureExample
//
//  Created by Islom on 04/01/23.
//

import UIKit

final class UserListCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let factory: UserListFactory
    private let makeUserDetailsCoordinator: (UINavigationController, User) -> Coordinator
    
    init(
        navigationController: UINavigationController,
        factory: UserListFactory,
        makeUserDetailsCoordinator: @escaping (UINavigationController, User) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.makeUserDetailsCoordinator = makeUserDetailsCoordinator
    }
    
    func start() {
        let vc = factory.makeUserListViewController(selection: showUserDetails)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showUserDetails(with user: User) {
        let coordinator = makeUserDetailsCoordinator(navigationController, user)
        coordinator.start()
    }
}
