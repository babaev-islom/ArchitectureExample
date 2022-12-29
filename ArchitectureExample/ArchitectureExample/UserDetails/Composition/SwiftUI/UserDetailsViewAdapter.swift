//
//  UserDetailsViewAdapter.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserDetailsViewAdapter {
    private let id: String
    private let loader: UserDetailsLoader
    private let viewModel: UserDetailsViewModel
    
    init(id: String, loader: UserDetailsLoader, viewModel: UserDetailsViewModel) {
        self.id = id
        self.loader = loader
        self.viewModel = viewModel
    }
    
    func loadDetails() {
        loader.loadUserDetails(by: id) { [viewModel] result in
            if case let .success(userDetails) = result {
                let details = UserDetailsItem(
                    age: "\(userDetails.age)",
                    description: userDetails.occupation + " - " + userDetails.address
                )
                viewModel.didFinishLoading(details)
            }
        }
    }
}
