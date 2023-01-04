//
//  UserDetailsFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 04/01/23.
//

import UIKit

protocol UserDetailsFactory {
    func makeUserDetailsViewController(selection: @escaping () -> Void) -> UIViewController
}

final class UIKitUserDetailsCoordinatorFactory: UserDetailsFactory {
    private let user: User
    private let apiClient: APIClientStub2
    
    init(user: User, apiClient: APIClientStub2) {
       self.user = user
       self.apiClient = apiClient
   }
    
    func makeUserDetailsViewController(selection: @escaping () -> Void) -> UIViewController {
        let url = URL(string: "https://any-url.com/details")!
        let remoteLoader = RemoteUserDetailsLoader(url: url, client: apiClient)
        let vc = UIKitUserDetailsFactory.makeUserDetailsListViewController(with: user, loader: remoteLoader, selection: selection)
        return vc
    }
}
