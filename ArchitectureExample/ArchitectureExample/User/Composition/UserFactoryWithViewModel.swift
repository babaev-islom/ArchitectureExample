//
//  UserFactoryWithViewModel.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

final class UserFactoryWithViewModel {
    private init() {}
    
    static func makeUserListViewController(
        loader: UserLoader,
        selection: @escaping (User) -> Void
    ) -> UIViewController {
        let mainQueueLoader = MainQueueDispatchDecorator(decoratee: loader)
        let viewModel = UserListViewModel()
        let adapter = UserViewWithViewModelAdapter(
            userLoader: mainQueueLoader,
            viewModel: viewModel,
            userSelection: selection
        )
        let controller = UserListViewController(onDataLoadRequest: adapter.loadUsers)
        controller.title = "User List"
        viewModel.isLoading = { [weak controller] isLoading in
            controller?.didStartLoading(isLoading: isLoading)
        }
        
        viewModel.onDataLoad = { [weak controller] items in
            controller?.didFinishLoading(users: items)
        }
        
        viewModel.onLoadError = { [weak controller] error in
            controller?.didFinishLoading(with: error)
        }
        return controller
    }
}
