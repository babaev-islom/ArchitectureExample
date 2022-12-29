//
//  UserDetailsViewControllerAdapter.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserDetailsViewControllerAdapter {
    weak var controller: UserDetailsViewController?
    
    private let id: String
    private let loader: UserDetailsLoader
    
    init(id: String, loader: UserDetailsLoader) {
        self.id = id
        self.loader = loader
    }
    
    func loadDetails() {
        loader.loadUserDetails(by: id) { [controller] result in
            if case let .success(userDetails) = result {
                let details = UserDetailsItem(
                    age: "\(userDetails.age)",
                    description: userDetails.occupation + " - " + userDetails.address
                )
                controller?.didFinishLoading(details: details)
            }
        }
    }
}
