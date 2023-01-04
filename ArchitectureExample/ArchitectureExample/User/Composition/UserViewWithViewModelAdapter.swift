//
//  UserViewWithViewModelAdapter.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation


//final class UserViewWithViewModelAdapter {
//    private let userLoader: UserLoader
//    private let viewModel: UserListViewModel
//    private let userSelection: (User) -> Void
//    
//    init(userLoader: UserLoader, viewModel: UserListViewModel, userSelection: @escaping (User) -> Void) {
//        self.userLoader = userLoader
//        self.viewModel = viewModel
//        self.userSelection = userSelection
//    }
//    
//    func loadUsers() {
//        viewModel.didStartLoading()
//
//        userLoader.loadUsers { [viewModel, userSelection] result in
//            switch result {
//            case let .success(users):
//                let userItems = users.map { user in
//                    UserItem(
//                        name: user.firstName + " " + user.lastName,
//                        email: user.email,
//                        selection: {
//                            userSelection(user)
//                        }
//                    )
//                }
//                viewModel.didFinishLoading(items: userItems)
//            case let .failure(error):
//                viewModel.didFinishLoading(with: error)
//            }
//        }
//    }
//}
