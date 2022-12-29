//
//  SwiftUIUserDetailsFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import SwiftUI

final class SwiftUIUserDetailsFactory {
    private init() {}
    
    static func makeUserDetailsListViewController(
        with user: User,
        loader: UserDetailsLoader
    ) -> UIViewController {
        let mainQueueLoader = MainQueueDispatchDecorator2(decoratee: loader)
        let viewModel = UserDetailsViewModel()
        let adapter = UserDetailsViewAdapter(id: user.id, loader: mainQueueLoader, viewModel: viewModel)
        let view = UserDetailsView(viewModel: viewModel, onDataLoadRequest: adapter.loadDetails)
        let controller = UIHostingController(rootView: view)
        controller.title = "User Details"
        return controller
    }
}
