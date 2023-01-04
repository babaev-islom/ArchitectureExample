//
//  UserDetailsCoordinator.swift
//  ArchitectureExample
//
//  Created by Islom on 04/01/23.
//

import UIKit

final class UserDetailsCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let factory: UserDetailsFactory
    private let makeRandomCoordinator: (UINavigationController) -> Coordinator
    
    init(
        navigationController: UINavigationController,
        factory: UserDetailsFactory,
        makeRandomCoordinator: @escaping (UINavigationController) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.makeRandomCoordinator = makeRandomCoordinator
    }
    
    func start() {
        let vc = factory.makeUserDetailsViewController(selection: showRandomCoordinator)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showRandomCoordinator() {
        let coordinator = makeRandomCoordinator(navigationController)
        coordinator.start()
    }
}

