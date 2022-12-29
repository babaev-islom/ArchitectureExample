//
//  UserDetailsFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

final class UIKitUserDetailsFactory {
    private init() {}
    
    static func makeUserDetailsListViewController(
        with user: User,
        loader: UserDetailsLoader
    ) -> UIViewController {
        let mainQueueLoader = MainQueueDispatchDecorator2(decoratee: loader)
        let adapter = UserDetailsViewControllerAdapter(id: user.id, loader: mainQueueLoader)
        let controller = UserDetailsViewController(onDataLoadRequest: adapter.loadDetails)
        adapter.controller = controller
        controller.title = "User Details"
        return controller
    }
}
